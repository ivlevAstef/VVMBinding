//
//  VVMObserverBind.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"
#import "VVMLogger.h"

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
    VVMBindMethodCheck userMethod = self.checkBlock;
    if (nil == userMethod) {
        return TRUE;
    }
    
    VVMLogDebug(@"Call user method 'check' for:%@", self);
    return userMethod(newValue);
}

- (id)observerTransformation:(id)newValue {
    VVMBindMethodTransformation userMethod = self.transformationBlock;
    if (nil == userMethod) {
        return newValue;
    }
    
    VVMLogDebug(@"Call user method 'transformation' for:%@", self);
    return userMethod(newValue);
}

- (void)observerUpdate:(id)newValue On:(id)callObj {
    VVMBindMethodUpdated userMethod = self.updatedBlock;
    BOOL successful = TRUE;
    
    @try {
        [callObj setValue:newValue forKeyPath:self.callPath.keyPath];
    } @catch (...) {
        successful = FALSE;
    }
    
    if (nil != userMethod) {
        VVMLogDebug(@"Call user method 'update' for:%@", self);
        userMethod(successful, newValue);
    }
}

- (void)observerExecute:(id)newValue {
    __strong typeof(self.callPath.parent) callObj = self.callPath.parent;
    if (nil == callObj) {
        VVMLogWarning(@"Observer can't found call object.");
        return;
    }
    
    if ([self observerCheck:newValue]) {
        newValue = [self observerTransformation:newValue];
        [self observerUpdate:newValue On:callObj];
    }
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@.%@ --> %@.%@", self.path.parent, self.path.keyPath, self.callPath.parent, self.callPath.keyPath];
}

@end
