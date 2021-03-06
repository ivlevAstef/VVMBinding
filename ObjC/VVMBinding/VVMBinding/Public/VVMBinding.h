//
//  VVMBinding.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVVMBind.h"

typedef NS_ENUM(NSUInteger, eVVMBindingDirection) {
    eVVMBindingDirection_To = 1 << 0,
    eVVMBindingDirection_From = 1 << 1,
    eVVMBindingDirection_Both = eVVMBindingDirection_To | eVVMBindingDirection_From,
};

typedef NS_ENUM(NSUInteger, eVVMBindingInitial) {
    eVVMBindingInitial_Nothing,
    eVVMBindingInitial_To,
    eVVMBindingInitial_From,
};

@interface VVMBinding : NSObject

+ (void)bind:(id)parent keyPath:(NSString*)keyPath direction:(eVVMBindingDirection)direction initial:(eVVMBindingInitial)initial with:(id)parent2 keyPath:(NSString*)keyPath2;

+ (id<IVVMBind>)bindObject:(id)parent keyPath:(NSString*)keyPath;

@end

#define VVMBind(PARENT, OBJ, DIRECTION, INITIAL, PARENT2, OBJ2) \
do { \
    typeof(PARENT.OBJ) __attribute__((unused)) check = PARENT.OBJ; \
    typeof(PARENT2.OBJ2) __attribute__((unused)) check2 = PARENT2.OBJ2; \
    [VVMBinding bind:PARENT keyPath:@#OBJ direction:eVVMBindingDirection_##DIRECTION initial:eVVMBindingInitial_##INITIAL with:PARENT2 keyPath:@#OBJ2]; \
} while(0)

#define VVMBindRead(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, From, From, PARENT2, OBJ2)
#define VVMBindReadWithoutInit(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, From, Nothing, PARENT2, OBJ2)

#define VVMBindWrite(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, To, To, PARENT2, OBJ2)
#define VVMBindWriteWithoutInit(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, To, Nothing, PARENT2, OBJ2)

#define VVMBindReadWrite(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, Both, From, PARENT2, OBJ2)
#define VVMBindReadWriteReverseInit(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, Both, To, PARENT2, OBJ2)
#define VVMBindReadWriteWithoutInit(PARENT, OBJ, PARENT2, OBJ2) VVMBind(PARENT, OBJ, Both, Nothing, PARENT2, OBJ2)

#define VVMBindObj(PARENT, OBJ) ({ \
    typeof(PARENT.OBJ) __attribute__((unused)) check = PARENT.OBJ; \
    [VVMBinding bindObject:PARENT keyPath:@#OBJ]; \
})
