//
//  IVVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^VVMBindMethodCheck)(id newValue);
typedef id (^VVMBindMethodTransformation)(id newValue);
typedef void (^VVMBindMethodUpdated)(BOOL success, id newValue);

@protocol IVVMBind <NSObject>

@property (atomic, copy) VVMBindMethodCheck checkBlock;
@property (atomic, copy) VVMBindMethodTransformation transformationBlock;
@property (atomic, copy) VVMBindMethodUpdated updatedBlock;

@end
