//
//  VVMBind.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBind.h"
#import <objc/runtime.h>

static char sVVMBindAssocoationKey = 0;

@interface VVMBind ()

@property (nonatomic, weak) id obj;
@property (nonatomic, copy) NSString* keyPath;

@property (nonatomic, weak) id callObj;
@property (nonatomic, copy) NSString* callKeyPath;

@property (nonatomic, assign) NSMutableSet* associations;

@end

@implementation VVMBind
@synthesize checkBlock;
@synthesize transformationBlock;
@synthesize updatedBlock;

+ (instancetype)createFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath initial:(BOOL)initial {
    return [[self alloc] initFor:obj withKeyPath:keyPath withCallObj:callObj withKeyPath:callKeyPath initial:initial];
}

- (id)initFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath initial:(BOOL)initial {
    assert(nil != obj && nil != keyPath && nil != callObj && nil != callKeyPath);
    
    self = [super init];
    if (self) {
        self.obj = obj;
        self.keyPath = keyPath;
        self.callObj = callObj;
        self.callKeyPath = callKeyPath;
        
        [self bindRetain];
        
        if (initial) {
            [self initial];
        }
    }
    
    return self;
}

- (void)setAssociations:(NSMutableSet*)associations {
    objc_setAssociatedObject(self.obj, &sVVMBindAssocoationKey, associations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet*)associations {
    return objc_getAssociatedObject(self.obj, &sVVMBindAssocoationKey) ?: [NSMutableSet set];
}

- (void)bindRetain {
    NSMutableSet* associations = [self associations];
    [associations addObject:self];
    [self setAssociations:associations];
}

- (void)bindRelease {
    NSMutableSet* associations = [self associations];
    [associations removeObject:self];
}

- (void)initial {
    @try {
        id value = [self.obj valueForKeyPath:self.keyPath];
        [self update:value];
    } @catch(...) {
    }
}


- (BOOL)check:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return FALSE;
    }
    
    VVMBindMethodCheck userMethod = self.checkBlock;
    if (nil == userMethod) {
        return TRUE;
    }
    
    return userMethod(newValue);
}

- (id)transformation:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return newValue;
    }
    
    VVMBindMethodTransformation userMethod = self.transformationBlock;
    if (nil == userMethod) {
        return newValue;
    }
    
    return userMethod(newValue);
}

- (void)update:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return;
    }
    
    VVMBindMethodUpdated userMethod = self.updatedBlock;
    BOOL successful = TRUE;
    
    @try {
        [self.callObj setValue:newValue forKeyPath:self.callKeyPath];
    } @catch (...) {
        successful = FALSE;
    }
    
    if (nil != userMethod) {
        userMethod(successful, newValue);
    }
}


@end
