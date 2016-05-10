//
//  VVMBinding.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMBinding.h"

#import "VVMBind.h"
#import "VVMKVObserver.h"

@implementation VVMBinding

+ (void)bind:(id)parent keyPath:(NSString*)keyPath direction:(eVVMBindingDirection)direction initial:(eVVMBindingInitial)initial with:(id)parent2 keyPath:(NSString*)keyPath2 {
    if (eVVMBindingDirection_To == (direction & eVVMBindingDirection_To)) {
        [self bind:parent keyPath:keyPath with:parent2 keyPath:keyPath2 initial:(eVVMBindingInitial_To == initial)];
    }
    
    if (eVVMBindingDirection_From == (direction & eVVMBindingDirection_From)) {
        [self bind:parent2 keyPath:keyPath2 with:parent keyPath:keyPath initial:(eVVMBindingInitial_From == initial)];
    }
}

+ (void)bind:(id)parent keyPath:(NSString*)keyPath with:(id)parent2 keyPath:(NSString*)keyPath2 initial:(BOOL)initial {
    [VVMKVObserver createFor:[VVMBind createFor:parent withKeyPath:keyPath withCallObj:parent2 withKeyPath:keyPath2 initial:initial]];
}

@end
