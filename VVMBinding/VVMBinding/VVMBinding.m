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

+ (void)bind:(id)parent keyPath:(NSString*)keyPath modificator:(eVVMBindingModificator)modificator with:(id)parent2 keyPath:(NSString*)keyPath2 {
    if (eVVMBindingModificator_To == (modificator & eVVMBindingModificator_To)) {
        [VVMKVObserver createFor:[VVMBind createFor:parent withKeyPath:keyPath withCallObj:parent2 withKeyPath:keyPath2]];
    }
    
    if (eVVMBindingModificator_From == (modificator & eVVMBindingModificator_From)) {
        [VVMKVObserver createFor:[VVMBind createFor:parent2 withKeyPath:keyPath2 withCallObj:parent withKeyPath:keyPath]];
    }
}

@end
