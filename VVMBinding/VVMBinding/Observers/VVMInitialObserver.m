//
//  VVMInitialObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMInitialObserver.h"

@implementation VVMInitialObserver

- (id)initByBind:(VVMObserverBind*)bind {
    assert(nil != bind);
    
    self = [super init];
    if (self) {
        [self initialBind:bind];
    }
    
    return self;
}

- (void)initialBind:(VVMObserverBind*)bind {
    id value = nil;
    @try {
        value = [bind.path.parent valueForKeyPath:bind.path.keyPath];
    } @catch(...) {
        return;
    }
    
    [bind observerExecute:value];
}

@end
