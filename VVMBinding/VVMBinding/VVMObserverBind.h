//
//  VVMObserverBind.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 07/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVMBind.h"

typedef void (^VVMObserverBindTransformationCallback)(id newValue);

@interface VVMObserverBind : VVMBind

+ (instancetype)createByPath:(VVMBindPath*)path withCallPath:(VVMBindPath*)callPath;

@property (nonatomic, readonly) VVMBindPath* callPath;
@property (nonatomic, strong) id observer;

- (BOOL)observerCheck:(id)newValue;
- (void)observerTransformation:(id)newValue callback:(VVMObserverBindTransformationCallback)callback;
- (void)observerUpdate:(id)newValue;

@end
