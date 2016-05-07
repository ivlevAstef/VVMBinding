//
//  ViewModel.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SampleViewModel.h"

@implementation SampleViewModel

- (id)init {
    self = [super init];
    
    if (self) {
        self.staticText = @"Sample Static Text";
        
        self.editableText = @"";
        self.editableTextPlaceholder = @"Write";
        
        self.dynamicValue = 25;
        self.dynamicValueMax = 100;
        self.dynamicValueMin = 0;
        
        self.booleanValue = TRUE;
        
        self.pickerData = @[
                            @"Value1",
                            @"Value2",
                            @"Value3",
                            @"Value4",
                            @"Value5"
                            ];
        
        [self runAutoUpdate];
    }
    
    return self;
}

- (void)runAutoUpdate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.staticText = @"Sample Static Text Update By Time";
    });
}

- (BOOL)VVMIsChangeEditableTextTo:(id)NewValue {
    NSLog(@"Editable Text is Changed with value:%@", NewValue);
    return TRUE;
}


- (id)VVMModificationEditableText:(id)NewValue {
    NSLog(@"Editable Text Modification from:%@", NewValue);
    return [NewValue lowercaseString];
}

- (void)VVMMChangedEditableTextTo:(id)NewValue {
    NSLog(@"Editable Text Changed:%@", NewValue);
}

- (void)VVMMIsChangeDynamicValueTo:(id)NewValue {
    NSLog(@"Dynamic Value Changed:%@", NewValue);
}

- (id)VVMModificationDynamicValue:(id)NewValue {
    NSLog(@"Dynamic Value Modification from:%@", NewValue);
    return NewValue;
}

- (void)VVMMChangedDynamicValueTo:(id)NewValue {
    NSLog(@"Dynamic Value Changed:%@", NewValue);
}

- (void)VVMMChangedBooleanValueTo:(id)NewValue {
    NSLog(@"Boolean Value Changed:%@", NewValue);
}

@end
