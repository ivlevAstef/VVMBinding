//
//  VVMUITextFieldObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUITextFieldObserver.h"
#import "VVMLogger.h"

@implementation VVMUITextFieldObserver

- (id)initByBind:(VVMObserverBind*)bind UseTextField:(UITextField*)textField {
    VVMLogAssert(nil != bind && nil != textField);
    
    self = [super initByBind:bind];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeValue:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        
    }
    
    return self;
}

- (void)changeValue:(NSNotification*)notification {
    __strong typeof(self.bind) bind = self.bind;
    if (nil == bind) {
        return;
    }
    
    UITextField* textField = [notification object];
    [self update:textField.text];
}

@end
