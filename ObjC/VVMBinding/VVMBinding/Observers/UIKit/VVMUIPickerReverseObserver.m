//
//  VVMUIPickerReverseObserver.m
//  VVMBinding
//
//  Created by Alexander Ivlev on 11/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "VVMUIPickerReverseObserver.h"
#import "VVMLogger.h"

@interface VVMUIPickerReverseObserver () <UIPickerViewDataSource>

@property (nonatomic, weak) UIPickerView* picker;

@property (nonatomic, strong) NSArray* data;
@property (nonatomic, assign) BOOL isComponents;

@end

@implementation VVMUIPickerReverseObserver

- (id)initByBind:(VVMObserverBind*)bind UsePicker:(UIPickerView*)picker {
    VVMLogAssert(nil != bind && nil != picker);
    
    self = [super initByBind:bind];
    if (self) {
        self.picker = picker;
        
        self.data = [NSArray array];
        self.isComponents = FALSE;
        self.picker.dataSource = self;
    }
    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    if (self.isComponents) {
        return self.data.count;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isComponents) {
        return ((NSArray*)self.data[component]).count;
    }
    return self.data.count;
}

- (BOOL)arrayIsContaintsSubArray:(NSArray*)testArray {
    for (id object in testArray) {
        if (![object isKindOfClass:[NSArray class]]) {
            return FALSE;
        }
    }
    
    return testArray.count > 1;
}

- (void)setValue:(NSArray*)newValue {
    __strong typeof(self.picker) picker = self.picker;
    if (nil == picker) {
        return;
    }
    
    if (![newValue isKindOfClass:[NSArray class]]) {
        VVMLogError(@"VVM UIPicker data can't updated, because incorrect type.");
        [self.bind observerNotify:NO withNewValue:newValue];
        return;
    }
    
    self.isComponents = [self arrayIsContaintsSubArray:newValue];
    self.data = newValue;
    [picker reloadAllComponents];
    
    [self.bind observerNotify:YES withNewValue:newValue];
}

@end