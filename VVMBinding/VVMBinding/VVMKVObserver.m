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

static char sVVMKVObserverAssocoationKey = 0;

@interface VVMKVObserver ()

@property (nonatomic, unsafe_unretained) id observeObject;
@property (nonatomic, copy) id observeKeyPath;

@property (nonatomic, weak) VVMBind* bind;

@end

@implementation VVMKVObserver

+ (void)createFor:(VVMBind*)bind {
    id __attribute__((unused)) unused = [[self alloc] initFor:bind];
}

- (id)initFor:(VVMBind*)bind {
    assert(nil != bind);
    
    self = [super init];
    if (self) {
        self.bind = bind;
        self.observeObject = self.bind.obj;
        self.observeKeyPath = self.bind.keyPath;
        
        [self.observeObject addObserver:self forKeyPath:self.observeKeyPath options:NSKeyValueObservingOptionNew context:nil];
        objc_setAssociatedObject(self.bind, &sVVMKVObserverAssocoationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    
    if ([bind check:newValue]) {
        newValue = [bind modification:newValue];
        [bind update:newValue];
    }
    
    isObserved = FALSE;
}

@end
