//
//  VVMTransformation.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 18/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^VVMBindMethodTransformation)(id newValue);

@interface VVMTransformation : NSObject

+ (VVMBindMethodTransformation)NSStringToUIImage;
+ (VVMBindMethodTransformation)NSStringToNSURL;

@end
