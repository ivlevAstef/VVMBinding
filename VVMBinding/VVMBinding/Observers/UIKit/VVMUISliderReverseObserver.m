//
//  VVMUISliderReverseObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISliderReverseObserver.h"
#import "VVMLogger.h"

static const NSTimeInterval sSliderAnimationTime = 0.25;

@interface VVMUISliderReverseObserver ()

@property (nonatomic, weak) UISlider* slider;
@property (nonatomic, assign) BOOL isInitial;

@end

@implementation VVMUISliderReverseObserver

- (id)initByBind:(VVMObserverBind*)bind UseSlider:(UISlider*)slider {
    VVMLogAssert(nil != bind && nil != slider);
    
    self = [super initByBind:bind];
    if (self) {
        self.slider = slider;
        self.isInitial = FALSE;
    }
    
    return self;
}

- (void)initial {
    self.isInitial = TRUE;
    [super initial];
    self.isInitial = FALSE;
}

- (void)update:(id)newValue {
    __strong typeof(self.slider) slider = self.slider;
    if (nil == slider) {
        return;
    }
    
    BOOL animated = !self.isInitial;
    
    if (animated) {
        [UIView animateWithDuration:sSliderAnimationTime animations:^{
            [slider setValue:[newValue floatValue] animated:YES];
        }];
    } else {
        [slider setValue:[newValue floatValue] animated:NO];
    }
}

@end
