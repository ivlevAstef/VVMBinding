//
//  SampleViewController.m
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SampleViewController.h"
#import "VVMBinding/VVMBinding.h"

@interface SampleViewController () <UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel* sampleLabel;//OK. NSString
@property (weak, nonatomic) IBOutlet UITextField* sampleTextField;//OK. NSString
@property (weak, nonatomic) IBOutlet UISlider* sampleSlider;//OK. float, int and NSNumber
@property (weak, nonatomic) IBOutlet UISwitch* sampleSwitch;//OK. BOOL and NSNumber
@property (weak, nonatomic) IBOutlet UIPickerView* samplePickerView;//OK. Only get data from NSArray.
@property (weak, nonatomic) IBOutlet UIImageView* sampleImageView;//OK. Support UIImage and NSString.
@property (weak, nonatomic) IBOutlet UIProgressView* sampleProgress;//OK. float and NSNumber
@property (weak, nonatomic) IBOutlet UISegmentedControl* sampleSegments;//OK. Only get data from NSArray.
@property (weak, nonatomic) IBOutlet UIButton* sampleButton;//No
@property (weak, nonatomic) IBOutlet UIStepper* sampleStepper;//No
@property (weak, nonatomic) IBOutlet UISearchBar* sampleSearchBar;//No

@property (nonatomic, strong) id<INavigator> navigator;
@property (nonatomic, strong) SampleViewModel* viewModel;

@end

@implementation SampleViewController

- (id)initWithNavigator:(id<INavigator>)navigator WithViewModel:(SampleViewModel*)viewModel {
    self = [super init];
    
    if (self) {
        self.navigator = navigator;
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bind:self.viewModel];
}

- (void)bind:(SampleViewModel*)viewModel {
    [VVMBindObj(self, sampleLabel.text) check:^BOOL (id newValue) {
        NSLog(@"Sample label is Changed with value:%@", newValue);
        return TRUE;
    }];
    
    [VVMBindObj(self, sampleLabel.text) transformation:^id(id newValue) {
        NSLog(@"Sample label Transformation with value:%@", newValue);
        return [newValue uppercaseString];
    }];
    
    [VVMBindObj(self, sampleLabel.text) updated:^void(BOOL success, id newValue) {
        NSLog(@"Sample label Updated %@ with value:%@", success ? @"success" : @"failed", newValue);
    }];
    
    VVMBindRead(self, sampleLabel.text, viewModel, staticText);
    
    VVMBindReadWrite(self, sampleTextField.text, viewModel, editableText);
    VVMBindRead(self, sampleTextField.placeholder, viewModel, editableTextPlaceholder);
    
    VVMBindRead(self, sampleSlider.minimumValue, viewModel, dynamicValueMin);
    VVMBindRead(self, sampleSlider.maximumValue, viewModel, dynamicValueMax);
    VVMBindReadWrite(self, sampleSlider.value, viewModel, dynamicValue);
    
    VVMBindReadWrite(self, sampleSwitch.on, viewModel, booleanValue);
    
    VVMBindRead(self, sampleImageView.image, viewModel, imageName);
    
    VVMBindReadWrite(self, sampleProgress.progress, viewModel, progressValue);
    
    VVMBindRead(self, sampleSegments, viewModel, segments);
    
    self.samplePickerView.delegate = self;
    VVMBindRead(self, samplePickerView, viewModel, pickerData);
}

- (nullable NSString *)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.samplePickerView.numberOfComponents > 1) {
        return [self.viewModel.pickerData[component][row] stringValue];
    }
    
    return self.viewModel.pickerData[row];
}

- (IBAction)close:(id)sender {
    [self.navigator showSample2View];
}

@end
