//
//  VVMUISwitchObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISwitchObserver.h"

@interface VVMUISwitchObserver ()

@property (nonatomic, weak) VVMObserverBind* bind;

@end

@implementation VVMUISwitchObserver

- (id)initByBind:(VVMObserverBind*)bind UseSwitch:(UISwitch*)uiSwitch {
    assert(nil != bind && nil != uiSwitch);
    
    self = [super init];
    if (self) {
        self.bind = bind;
        
        [uiSwitch addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)changeValue:(UISwitch*)sender {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    [bind observerExecute:@([sender isOn])];
}

@end