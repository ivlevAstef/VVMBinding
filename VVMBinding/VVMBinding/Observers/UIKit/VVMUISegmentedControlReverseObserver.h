//
//  VVMUISegmentedControlReverseObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 19/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"
#import "VVMKVObserver.h"
#import <UIKit/UIKit.h>

@interface VVMUISegmentedControlReverseObserver : VVMKVObserver

- (id)initByBind:(VVMObserverBind*)bind UseSegmentedControl:(UISegmentedControl*)segmentedControl;

@end
