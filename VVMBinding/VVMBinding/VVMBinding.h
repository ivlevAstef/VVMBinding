//
//  VVMBinding.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, eVVMBindingModificator) {
    eVVMBindingModificator_To = 1 << 0,
    eVVMBindingModificator_From = 1 << 1,
    eVVMBindingModificator_Both = eVVMBindingModificator_To | eVVMBindingModificator_From,
};


/**
 *  Called Methods:
 *  - (BOOL)VVMIsChange@KeyPath@To:(id)NewValue;
 *  - (id)VVMModification@KeyPath@:(id)NewValue;
 *  - (void)VVMMChanged@KeyPath@To:(id)NewValue;
 *  - (void)VVMMNotChanges@KeyPath@To:(id)NewValue;
 *
 *  Where @KeyPath@ Construct from keyPath value by algorithm: someName.value -> SomeNameValue
 */
@interface VVMBinding : NSObject

+ (void)bind:(id)parent keyPath:(NSString*)keyPath modificator:(eVVMBindingModificator)modificator with:(id)parent2 keyPath:(NSString*)keyPath2;

@end

#define VVMBind(PARENT, OBJ, MODIFICATOR, PARENT2, OBJ2) \
do { \
    typeof(PARENT.OBJ) __attribute__((unused)) check = PARENT.OBJ; \
    typeof(PARENT2.OBJ2) __attribute__((unused)) check2 = PARENT2.OBJ2; \
    [VVMBinding bind:PARENT keyPath:@#OBJ modificator:eVVMBindingModificator_##MODIFICATOR with:PARENT2 keyPath:@#OBJ2]; \
} while(0);
