//
//  VVMObserverBind.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"
#import <objc/runtime.h>

@interface VVMObserverBind ()

@property (nonatomic, strong) VVMBindPath* callPath;

@end

@implementation VVMObserverBind

+ (instancetype)createByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath {
    return [[self alloc] initByPath:path withCallPath:callPath];
}

- (id)initByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath {
    self = [super initByPath:path];
    if (self) {
        self.callPath = callPath;
    }
    
    return self;
}

- (BOOL)observerCheck:(id)newValue {
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

- (id)observerTransformation:(id)newValue {
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

- (void)observerUpdate:(id)newValue {
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
