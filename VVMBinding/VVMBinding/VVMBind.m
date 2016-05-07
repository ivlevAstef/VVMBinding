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

+ (instancetype)createFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath {
    return [[self alloc] initFor:obj withKeyPath:keyPath withCallObj:callObj withKeyPath:callKeyPath];
}

- (id)initFor:(id)obj withKeyPath:(NSString*)keyPath withCallObj:(id)callObj withKeyPath:(NSString*)callKeyPath {
    assert(nil != obj && nil != keyPath && nil != callObj && nil != callKeyPath);
    
    self = [super init];
    if (self) {
        self.obj = obj;
        self.keyPath = keyPath;
        self.callObj = callObj;
        self.callKeyPath = callKeyPath;
        
        [self bindRetain];
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

- (NSString*)selectorName {
    NSCharacterSet* separators = [NSCharacterSet characterSetWithCharactersInString:@". "];
    NSArray<NSString*>* substrings = [self.callKeyPath componentsSeparatedByCharactersInSet:separators];
    
    NSString* result = @"";
    for (NSString* substr in substrings) {
        NSString* upperCaseStr = [NSString stringWithFormat:@"%@%@",[[substr substringToIndex:1] uppercaseString],[substr substringFromIndex:1]];
        result = [result stringByAppendingString:upperCaseStr];
    }
    
    return result;
}

- (NSInvocation*)createInvocation:(id)obj WithSelector:(SEL)selector {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[obj class] instanceMethodSignatureForSelector:selector]];
    
    [invocation setSelector:selector];
    [invocation setTarget:obj];
    
    return invocation;
}

- (BOOL)checkAndCallMethodIsChangeOn:(id)callObj WithObj:(id)obj {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"VVMIsChange%@To:", [self selectorName]]);
    
    if ([callObj respondsToSelector:selector]) {
        NSInvocation *invocation = [self createInvocation:callObj WithSelector:selector];
        [invocation setArgument:&obj atIndex:2];
        
        [invocation invoke];
        
        BOOL result = FALSE;
        [invocation getReturnValue:&result];
        return result;
    }
    
    return TRUE;
}

- (id)checkAndCallMethodModificationOn:(id)callObj WithObj:(id)obj {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"VVMModification%@:", [self selectorName]]);
    
    if ([callObj respondsToSelector:selector]) {
        NSInvocation *invocation = [self createInvocation:callObj WithSelector:selector];
        [invocation setArgument:&obj atIndex:2];
        
        [invocation invoke];
        
        void* result = nil;
        [invocation getReturnValue:&result];
        return (__bridge id)(result);
    }
    
    return obj;
}

- (void)checkAndCallMethodChanged:(id)callObj WithObj:(id)obj {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"VVMMChanged%@To:", [self selectorName]]);
    
    if ([callObj respondsToSelector:selector]) {
        NSInvocation *invocation = [self createInvocation:callObj WithSelector:selector];
        [invocation setArgument:&obj atIndex:2];
        
        [invocation invoke];
    }
}

- (void)checkAndCallMethodDidNotChanged:(id)callObj WithObj:(id)obj {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"VVMMNotChanges%@To:", [self selectorName]]);
    
    if ([callObj respondsToSelector:selector]) {
        NSInvocation *invocation = [self createInvocation:callObj WithSelector:selector];
        [invocation setArgument:&obj atIndex:2];
        
        [invocation invoke];
    }
}

- (BOOL)check:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return FALSE;
    }
    
    return [self checkAndCallMethodIsChangeOn:callObj WithObj:newValue];
}

- (id)modification:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return newValue;
    }
    
    return [self checkAndCallMethodModificationOn:callObj WithObj:newValue];
}

- (void)update:(id)newValue {
    __strong typeof(self.callObj) callObj = self.callObj;
    if (nil == callObj) {
        return;
    }

    @try {
        [self.callObj setValue:newValue forKeyPath:self.callKeyPath];
    } @catch (...) {
        [self checkAndCallMethodDidNotChanged:callObj WithObj:newValue];
        return;
    }
    
    [self checkAndCallMethodChanged:callObj WithObj:newValue];
}


@end
