//
//  VVMBind.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBind.h"
#import <objc/runtime.h>

static char sVVMBindAssociationKey = 0;

@interface VVMBind ()

@property (nonatomic, strong) VVMBindPath* path;
@property (nonatomic, assign) NSMutableSet* associations;

@end

@implementation VVMBind

+ (instancetype)createByPath:(VVMBindPath*)path {
    return [[self alloc] initByPath:path];
}

- (id)initByPath:(VVMBindPath*)path {
    self = [super init];
    if (self) {
        self.path = path;
        
        [self bindRetain];
    }
    
    return self;
}

- (void)unbind {
    [self bindRelease];
}

- (void)setAssociations:(NSMutableSet*)associations {
    objc_setAssociatedObject(self.path.parent, &sVVMBindAssociationKey, associations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet*)associations {
    return objc_getAssociatedObject(self.path.parent, &sVVMBindAssociationKey) ?: [NSMutableSet set];
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

- (void)check:(VVMBindMethodCheck)checkBlock {
    self.checkBlock = checkBlock;
}

- (void)transformation:(VVMBindMethodTransformation)transformationBlock {
    self.transformationBlock = transformationBlock;
}

- (void)updated:(VVMBindMethodUpdated)updatedBlock {
    self.updatedBlock = updatedBlock;
}

- (void)copyTo:(VVMBind*)object {
    assert(nil != object);
    
    object.checkBlock = self.checkBlock;
    object.transformationBlock = self.transformationBlock;
    object.updatedBlock = self.updatedBlock;
}

@end
