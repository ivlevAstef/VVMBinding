//
//  ViewModel.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleViewModel : NSObject

@property (strong, nonatomic) NSString* staticText;

@property (strong, nonatomic) NSString* editableText;
@property (strong, nonatomic) NSString* editableTextPlaceholder;

@property (assign, nonatomic) float dynamicValue;
@property (assign, nonatomic) float dynamicValueMin;
@property (assign, nonatomic) float dynamicValueMax;

@property (assign, nonatomic) BOOL booleanValue;
@property (strong, nonatomic) NSArray* pickerData;

@end

