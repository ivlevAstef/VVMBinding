//
//  VVMObserverBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVMBind.h"

@interface VVMObserverBind : VVMBind

+ (instancetype)createByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath;

@property (nonatomic, strong) id observer;

- (void)observerExecute:(id)newValue;

@end
