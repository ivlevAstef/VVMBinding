//
//  ViewModel.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleViewModel : NSObject

@property (readonly, nonatomic) NSString* staticText;

@property (strong, nonatomic) NSString* editableText;
@property (readonly, nonatomic) NSString* editableTextPlaceholder;

@property (assign, nonatomic) float dynamicValue;
@property (readonly, nonatomic) float dynamicValueMin;
@property (readonly, nonatomic) float dynamicValueMax;

@property (assign, nonatomic) BOOL booleanValue;

@property (readonly, nonatomic) float progressValue;

@property (readonly, nonatomic) NSArray* pickerData;
@property (readonly, nonatomic) NSArray* segments;

@property (readonly, nonatomic) NSString* imageName;

@property (readonly, nonatomic) NSString* close;

@end

