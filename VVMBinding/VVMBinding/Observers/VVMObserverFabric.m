//
//  VVMObserverFabric.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverFabric.h"

#import "VVMKVObserver.h"
#import "VVMInitialObserver.h"

@implementation VVMObserverFabric

+ (id)createByBind:(VVMObserverBind*)bind withInitial:(BOOL)initial {
    if (initial) {
        id __attribute__((unused)) unused = [[VVMInitialObserver alloc] initByBind:bind];
    }
    
    id observer = [[VVMKVObserver alloc] initByBind:bind];
    bind.observer = observer;
    
    return observer;
}

@end
