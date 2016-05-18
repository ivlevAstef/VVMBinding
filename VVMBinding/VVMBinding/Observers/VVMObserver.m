//
//  VVMObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserver.h"
#import "VVMLogger.h"

@interface VVMObserver ()

@property (nonatomic, weak) VVMObserverBind* bind;

@end

@implementation VVMObserver

- (id)initByBind:(VVMObserverBind*)bind {
    VVMLogAssert(nil != bind);
    
    self = [super init];
    if (self) {
        self.bind = bind;
    }
    
    return self;
}

- (void)initial {
    VVMLogAssert(nil != self.bind);
    
    id value = nil;
    @try {
        value = [self.bind.path.parent valueForKeyPath:self.bind.path.keyPath];
    } @catch(...) {
        return;
    }
    
    [self update:value];
}

- (void)update:(id)newValue {
    VVMLogAssert(nil != self.bind);
    
    if ([self.bind observerCheck:newValue]) {
        [self.bind observerTransformation:newValue callback:^(id newValue) {
           [self.bind observerUpdate:newValue]; 
        }];
    }
}

@end
