//
//  VVMUISliderObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISliderObserver.h"

@interface VVMUISliderObserver ()

@property (nonatomic, weak) VVMObserverBind* bind;

@end

@implementation VVMUISliderObserver

- (id)initByBind:(VVMObserverBind*)bind UseSlider:(UISlider*)slider {
    assert(nil != bind && nil != slider);
    
    self = [super init];
    if (self) {
        self.bind = bind;
        
        [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)changeValue:(UISlider*)sender {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    [bind observerExecute:@([sender value])];
}

@end