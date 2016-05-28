//
//  VVMTransformation.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 18/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVMTransformation.h"

@implementation VVMTransformation

+ (VVMBindMethodTransformation)NSStringToUIImage {
  return ^id(NSString* str) {
    if (nil != str) {
      return [UIImage imageNamed:str];
    }
    return nil;
  };
}

+ (VVMBindMethodTransformation)NSStringToNSURL {
  return ^id(NSString* str) {
    if (nil != str) {
      return [NSURL URLWithString:str];
    }
    return nil;
  };
}

@end
