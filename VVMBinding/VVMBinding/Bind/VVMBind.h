//
//  VVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVVMBind.h"
#import "VVMBindPath.h"

@interface VVMBind : NSObject <IVVMBind>

+ (instancetype)createByPath:(VVMBindPath*)path;
- (id)initByPath:(VVMBindPath*)path;

- (void)unbind;

@property (nonatomic, readonly) VVMBindPath* path;

@property (atomic, readonly) VVMBindMethodCheck checkBlock;
@property (atomic, readonly) VVMBindMethodTransformation transformationBlock;
@property (atomic, readonly) VVMBindMethodUpdated updatedBlock;

@property (atomic, readonly) eVVMPriority priority;

- (void)copyTo:(VVMBind*)object;

@end
