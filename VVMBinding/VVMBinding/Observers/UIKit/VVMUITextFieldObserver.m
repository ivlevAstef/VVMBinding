//
//  VVMUITextFieldObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUITextFieldObserver.h"

@interface VVMUITextFieldObserver ()

@property (nonatomic, weak) VVMObserverBind* bind;

@end

@implementation VVMUITextFieldObserver

- (id)initByBind:(VVMObserverBind*)bind UseTextField:(UITextField*)textField {
    assert(nil != bind && nil != textField);
    
    self = [super init];
    if (self) {
        self.bind = bind;
        
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
    [bind observerExecute:textField.text];
}

@end
