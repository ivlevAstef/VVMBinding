//
//  VVMBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVMBindBase.h"
#import "VVMBindPath.h"

@interface VVMBind : VVMBindBase

+ (instancetype)createByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath;

- (void)initial;

@property (nonatomic, readonly) VVMBindPath* callPath;

@property (nonatomic, strong) id observer;

- (BOOL)checkPackage:(id)newValue;
- (id)transformationPackage:(id)newValue;
- (void)updatePackage:(id)newValue;

@end
