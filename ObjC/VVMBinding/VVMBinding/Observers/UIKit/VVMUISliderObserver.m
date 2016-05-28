//
//  VVMUISliderObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISliderObserver.h"
#import "VVMLogger.h"

@implementation VVMUISliderObserver

- (id)initByBind:(VVMObserverBind*)bind UseSlider:(UISlider*)slider {
    VVMLogAssert(nil != bind && nil != slider);
    
    self = [super initByBind:bind];
    if (self) {        
        [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)changeValue:(UISlider*)sender {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    [self update:@([sender value])];
}

@end