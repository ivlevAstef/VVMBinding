//
//  ViewModel.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SampleViewModel.h"
#import "VVMBinding/VVMBinding.h"

@interface SampleViewModel ()

@property (strong, nonatomic) NSString* staticText;

//@property (strong, nonatomic) NSString* editableText;
@property (strong, nonatomic) NSString* editableTextPlaceholder;

//@property (assign, nonatomic) float dynamicValue;
@property (assign, nonatomic) float dynamicValueMin;
@property (assign, nonatomic) float dynamicValueMax;

//@property (assign, nonatomic) BOOL booleanValue;

@property (assign, nonatomic) float progressValue;

@property (strong, nonatomic) NSArray* pickerData;

@property (strong, nonatomic) NSString* imageName;

@property (strong, nonatomic) NSString* close;

@end

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
      
        self.progressValue = 0.1;
      
        self.pickerData = @[
                            @"Value1",
                            @"Value2",
                            @"Value3",
                            @"Value4",
                            @"Value5"
                            ];
        
        self.imageName = @"Test";
        self.close = @"Close Window";
        
        [self runAutoUpdate];
        
        [self bindMethods];
    }
    
    return self;
}

- (void)runAutoUpdate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imageName = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.imageName = @"Test";
        });
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.staticText = @"Sample Static Text Update By Time";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.booleanValue = TRUE;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dynamicValue = 80;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressValue = 0.5;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressValue = 1.0;
        });
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pickerData = @[
                            @"NewValue1",
                            @"NewValue2",
                            @"NewValue3",
                            @"NewValue4",
                            @"NewValue5",
                            @"NewValue6",
                            @"NewValue7"
                            ];
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
