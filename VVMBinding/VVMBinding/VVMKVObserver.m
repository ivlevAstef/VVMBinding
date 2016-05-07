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

static volatile int32_t isExecuted = FALSE;


@interface VVMKVObserver ()

@property (nonatomic, unsafe_unretained) VVMBind* bind;

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
        
        [self.bind.obj addObserver:self forKeyPath:self.bind.keyPath options:NSKeyValueObservingOptionNew context:nil];
        objc_setAssociatedObject(self.bind, (__bridge const void *)(self), self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self;
}

- (void)dealloc {
    [self.bind.obj removeObserver:self forKeyPath:self.bind.keyPath];
    self.bind = nil;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if (!OSAtomicCompareAndSwap32(FALSE, TRUE, &isExecuted)) {
        return;
    }
    
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    if ([self.bind check:newValue]) {
        newValue = [self.bind modification:newValue];
        [self.bind update:newValue];
    }
    
    isExecuted = FALSE;
}

@end
