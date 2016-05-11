//
//  VVMUIPickerDataSourceObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"
#import "VVMKVObserver.h"
#import <UIKit/UIKit.h>

@interface VVMUIPickerDataSourceObserver : VVMKVObserver

- (id)initByBind:(VVMObserverBind*)bind UsePicker:(UIPickerView*)picker;

@end
