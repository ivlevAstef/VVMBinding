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

- (void)setValue:(NSNumber*)newValue {
    __strong typeof(self.slider) slider = self.slider;
    if (nil == slider) {
        return;
    }
    
    if (![newValue isKindOfClass:[NSNumber class]]) {
        VVMLogError(@"VVM UISlider.value can't updated, because incorrect type.");
        [self.bind observerNotify:NO withNewValue:newValue];
        return;
    }
    
    BOOL animated = !self.isInitial;
    
    if (animated) {
        [UIView animateWithDuration:sSliderAnimationTime animations:^{
            [slider setValue:[newValue floatValue] animated:YES];
        } completion:^(BOOL finished) {
            [self.bind observerNotify:YES withNewValue:newValue];
        }];
    } else {
        [slider setValue:[newValue floatValue] animated:NO];
        [self.bind observerNotify:YES withNewValue:newValue];
    }
    
    
    
}

@end
