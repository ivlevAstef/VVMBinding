//
//  VVMKVObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMKVObserver.h"
#import "VVMLogger.h"

#import <objc/runtime.h>
#import <libkern/OSAtomic.h>

static volatile int32_t isObserved = FALSE;

@interface VVMKVObserver ()

@property (nonatomic, unsafe_unretained) id observeObject;
@property (nonatomic, copy) id observeKeyPath;

@end

@implementation VVMKVObserver

- (id)initByBind:(VVMObserverBind*)bind {
    VVMLogAssert(nil != bind);
    
    self = [super initByBind:bind];
    if (self) {
        self.observeObject = self.bind.path.parent;
        self.observeKeyPath = self.bind.path.keyPath;
        
        [self.observeObject addObserver:self forKeyPath:self.observeKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)dealloc {
    [self.observeObject removeObserver:self forKeyPath:self.observeKeyPath];
    self.observeObject = nil;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    if (!OSAtomicCompareAndSwap32(FALSE, TRUE, &isObserved)) {
        return;
    }
    
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    if ([newValue isKindOfClass:[NSNull class]]) {
        newValue = nil;
    }
    
    [self update:newValue];
    
    isObserved = FALSE;
}

@end
