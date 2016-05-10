//
//  VVMUISliderObserver.h
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMObserverBind.h"
#import <UIKit/UIKit.h>

@interface VVMUISliderObserver : NSObject

- (id)initByBind:(VVMObserverBind*)bind UseSlider:(UISlider*)slider;

@end
