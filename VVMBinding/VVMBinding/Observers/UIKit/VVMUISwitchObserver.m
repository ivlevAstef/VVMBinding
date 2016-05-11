//
//  VVMUISwitchObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISwitchObserver.h"
#import "VVMLogger.h"

@implementation VVMUISwitchObserver

- (id)initByBind:(VVMObserverBind*)bind UseSwitch:(UISwitch*)uiSwitch {
    VVMLogAssert(nil != bind && nil != uiSwitch);
    
    self = [super initByBind:bind];
    if (self) {        
        [uiSwitch addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)changeValue:(UISwitch*)sender {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    [self update:@([sender isOn])];
}

@end