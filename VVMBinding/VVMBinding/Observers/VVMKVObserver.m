//
//  VVMKVObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMKVObserver.h"
#import <objc/runtime.h>
#import <libkern/OSAtomic.h>

static volatile int32_t isObserved = FALSE;

@interface VVMKVObserver ()

@property (nonatomic, unsafe_unretained) id observeObject;
@property (nonatomic, copy) id observeKeyPath;

@property (nonatomic, weak) VVMObserverBind* bind;

@end

@implementation VVMKVObserver

- (id)initByBind:(VVMObserverBind*)bind {
    assert(nil != bind);
    
    self = [super init];
    if (self) {
        self.bind = bind;
        
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
    
    if ([bind observerCheck:newValue]) {
        newValue = [bind observerTransformation:newValue];
        [bind observerUpdate:newValue];
    }
    
    isObserved = FALSE;
}

@end