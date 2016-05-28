//
//  VVMUITextFieldObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserver.h"
#import <UIKit/UIKit.h>

@interface VVMUITextFieldObserver : VVMObserver

- (id)initByBind:(VVMObserverBind*)bind UseTextField:(UITextField*)textField;

@end
