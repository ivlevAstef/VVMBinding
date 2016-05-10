//
//  VVMBindBase.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVVMBind.h"
#import "VVMBindPath.h"

@interface VVMBindBase : NSObject <IVVMBind>

+ (instancetype)createByPath:(VVMBindPath*)path;
- (id)initByPath:(VVMBindPath*)path;

- (void)unbind;

@property (nonatomic, readonly) VVMBindPath* path;

@property (atomic, copy) VVMBindMethodCheck checkBlock;
@property (atomic, copy) VVMBindMethodTransformation transformationBlock;
@property (atomic, copy) VVMBindMethodUpdated updatedBlock;

- (void)copyTo:(VVMBindBase*)object;

@end
