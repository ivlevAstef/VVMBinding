//
//  VVMBind.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBind.h"
#import <objc/runtime.h>

@interface VVMBind ()

@property (nonatomic, strong) VVMBindPath* callPath;

@end

@implementation VVMBind

+ (instancetype)createByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath {
    return [[self alloc] initByPath:path withCallPath:callPath];
}

- (id)initByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath{
    self = [super initByPath:path];
    if (self) {
        self.callPath = callPath;
    }
    
    return self;
}

- (void)initial {
    @try {
        id value = [self.path.parent valueForKeyPath:self.path.keyPath];
        if ([self checkPackage:value]) {
            value = [self transformationPackage:value];
            [self updatePackage:value];
        }
    } @catch(...) {
    }
}

- (BOOL)checkPackage:(id)newValue {
    __strong typeof(self.callPath.parent) callObj = self.callPath.parent;
    if (nil == callObj) {
        return FALSE;
    }
    
    VVMBindMethodCheck userMethod = self.checkBlock;
    if (nil == userMethod) {
        return TRUE;
    }
    
    return userMethod(newValue);
}

- (id)transformationPackage:(id)newValue {
    __strong typeof(self.callPath.parent) callObj = self.callPath.parent;
    if (nil == callObj) {
        return newValue;
    }
    
    VVMBindMethodTransformation userMethod = self.transformationBlock;
    if (nil == userMethod) {
        return newValue;
    }
    
    return userMethod(newValue);
}

- (void)updatePackage:(id)newValue {
    __strong typeof(self.callPath.parent) callObj = self.callPath.parent;
    if (nil == callObj) {
        return;
    }
    
    VVMBindMethodUpdated userMethod = self.updatedBlock;
    BOOL successful = TRUE;
    
    @try {
        [callObj setValue:newValue forKeyPath:self.callPath.keyPath];
    } @catch (...) {
        successful = FALSE;
    }
    
    if (nil != userMethod) {
        userMethod(successful, newValue);
    }
}

@end
