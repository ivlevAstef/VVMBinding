//
//  IVVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVMTransformation.h"

typedef NS_ENUM(long, eVVMPriority) {
    VVMPriority_Runtime = INT16_MAX,
    VVMPriority_High = DISPATCH_QUEUE_PRIORITY_HIGH,
    VVMPriority_Default = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    VVMPriority_Low = DISPATCH_QUEUE_PRIORITY_LOW,
    VVMPriority_Background = DISPATCH_QUEUE_PRIORITY_BACKGROUND
};

typedef BOOL (^VVMBindMethodCheck)(id newValue);
typedef void (^VVMBindMethodUpdated)(BOOL success, id newValue);

typedef void (^VVMBindMethodReceivedCommand)();

@protocol IVVMBind <NSObject>

- (void)check:(VVMBindMethodCheck)checkBlock;

- (void)transformation:(VVMBindMethodTransformation)transformationBlock;
- (void)transformation:(VVMBindMethodTransformation)transformationBlock priority:(eVVMPriority)priority;

- (void)updated:(VVMBindMethodUpdated)updatedBlock;

@end
