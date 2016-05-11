//
//  VVMUISliderReverseObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMKVObserver.h"
#import <UIKit/UIKit.h>

@interface VVMUISliderReverseObserver : VVMKVObserver

- (id)initByBind:(VVMObserverBind*)bind UseSlider:(UISlider*)slider;

@end
