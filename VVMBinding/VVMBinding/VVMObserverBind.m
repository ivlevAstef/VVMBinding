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

- (void)observerTransformation:(id)newValue callback:(VVMObserverBindTransformationCallback)callback {
    VVMLogAssert(nil != callback);
    
    VVMBindMethodTransformation userMethod = self.transformationBlock;
    if (nil == userMethod) {
        callback(newValue);
        return;
    }
    
    if (VVMPriority_Runtime == self.priority) {
        VVMLogDebug(@"Call user method 'transformation' for:%@", self);
        callback(userMethod(newValue));
    } else {
        dispatch_async(dispatch_get_global_queue(self.priority, 0), ^{
            VVMLogDebug(@"Call user method 'transformation' for:%@", self);
            id newTransformValue = userMethod(newValue);
            dispatch_sync(dispatch_get_main_queue(), ^{
                callback(newTransformValue);
            });
        });
    }
}

- (void)observerUpdate:(id)newValue {
    __strong typeof(self.callPath.parent) callObj = self.callPath.parent;
    if (nil == callObj) {
        VVMLogWarning(@"Observer can't found call object.");
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
        VVMLogDebug(@"Call user method 'update' for:%@", self);
        userMethod(successful, newValue);
    }
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@.%@ --> %@.%@", self.path.parent, self.path.keyPath, self.callPath.parent, self.callPath.keyPath];
}

@end
