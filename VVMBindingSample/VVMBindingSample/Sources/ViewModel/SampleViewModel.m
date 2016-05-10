//
//  ViewModel.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SampleViewModel.h"
#import "VVMBinding/VVMBinding.h"

@implementation SampleViewModel

- (id)init {
    self = [super init];
    
    if (self) {
        self.staticText = @"Sample Static Text";
        
        self.editableText = @"Test Text";
        self.editableTextPlaceholder = @"Write";
        
        self.dynamicValue = 25;
        self.dynamicValueMax = 100;
        self.dynamicValueMin = 0;
        
        self.booleanValue = FALSE;
        
        self.pickerData = @[
                            @"Value1",
                            @"Value2",
                            @"Value3",
                            @"Value4",
                            @"Value5"
                            ];
        
        [self runAutoUpdate];
        
        [self bindMethods];
    }
    
    return self;
}

- (void)runAutoUpdate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.staticText = @"Sample Static Text Update By Time";
    });
}


- (void)bindMethods {
    [VVMBindObj(self, editableText) check:^BOOL (id newValue) {
        NSLog(@"Editable Text is Changed with value:%@", newValue);
        return TRUE;
    }];
    
    [VVMBindObj(self, editableText) transformation:^id(id newValue) {
        NSLog(@"Editable Text Transformation with value:%@", newValue);
        return [newValue lowercaseString];
    }];
    
    [VVMBindObj(self, editableText) updated:^void(BOOL success, id newValue) {
        NSLog(@"Editable Text Changed:%@ %@", newValue, success ? @"success" : @"failed");
    }];
    
    [VVMBindObj(self, dynamicValue) updated:^void(BOOL success, id newValue) {
        NSLog(@"Dynamic value Changed:%@ %@", newValue, success ? @"success" : @"failed");
    }];
    
    
    [VVMBindObj(self, booleanValue) updated:^void(BOOL success, id newValue) {
        NSLog(@"Boolean value Changed:%@ %@", newValue, success ? @"success" : @"failed");
    }];

}

@end
