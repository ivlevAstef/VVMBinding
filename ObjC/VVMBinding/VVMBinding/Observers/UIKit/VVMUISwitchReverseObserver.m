//
//  VVMUISwitchReverseObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUISwitchReverseObserver.h"
#import "VVMLogger.h"

@interface VVMUISwitchReverseObserver ()

@property (nonatomic, weak) UISwitch* uiSwitch;
@property (nonatomic, assign) BOOL isInitial;

@end

@implementation VVMUISwitchReverseObserver

- (id)initByBind:(VVMObserverBind*)bind UseSwitch:(UISwitch*)uiSwitch {
    VVMLogAssert(nil != bind && nil != uiSwitch);
    
    self = [super initByBind:bind];
    if (self) {
        self.uiSwitch = uiSwitch;
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
    __strong typeof(self.uiSwitch) uiSwitch = self.uiSwitch;
    if (nil == uiSwitch) {
        return;
    }    
    
    if (![newValue isKindOfClass:[NSNumber class]]) {
        VVMLogError(@"VVM UISwitch.on can't updated, because incorrect type.");
        [self.bind observerNotify:NO withNewValue:newValue];
        return;
    }
    
    BOOL animated = !self.isInitial;
    
    [self.uiSwitch setOn:[newValue boolValue] animated:animated];
    [self.bind observerNotify:YES withNewValue:newValue];
}

@end
