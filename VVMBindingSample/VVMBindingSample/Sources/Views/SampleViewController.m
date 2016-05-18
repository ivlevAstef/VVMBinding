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

@property (weak, nonatomic) IBOutlet UILabel* sampleLabel;//OK
@property (weak, nonatomic) IBOutlet UITextField* sampleTextField;//OK
@property (weak, nonatomic) IBOutlet UISlider* sampleSlider;//OK
@property (weak, nonatomic) IBOutlet UISwitch* sampleSwitch;//OK
@property (weak, nonatomic) IBOutlet UIPickerView* samplePickerView;//Only get data from NSArray. Support is open question.
@property (weak, nonatomic) IBOutlet UIImageView* sampleImageView;//Only UIImage. Needs support NSString and NSURL
@property (weak, nonatomic) IBOutlet UIButton* sampleButton;//No
@property (weak, nonatomic) IBOutlet UISegmentedControl* sampleSegments;//No
@property (weak, nonatomic) IBOutlet UIProgressView* sampleProgress;//No
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
    
    [VVMBindObj(self, sampleImageView.image) transformation:[VVMTransformation NSStringToUIImage] priority:VVMPriority_Default];
    
    VVMBind(self, sampleLabel.text, From, From, viewModel, staticText);
    
    VVMBind(self, sampleTextField.text, Both, From, viewModel, editableText);
    VVMBind(self, sampleTextField.placeholder, From, From, viewModel, editableTextPlaceholder);
    
    VVMBind(self, sampleSlider.minimumValue, From, From, viewModel, dynamicValueMin);
    VVMBind(self, sampleSlider.maximumValue, From, From, viewModel, dynamicValueMax);
    VVMBind(self, sampleSlider.value, Both, From, viewModel, dynamicValue);
    
    VVMBind(self, sampleSwitch.on, Both, From, viewModel, booleanValue);
    
    VVMBind(self, sampleImageView.image, From, From, viewModel, imageName);
    
    self.samplePickerView.delegate = self;
    VVMBind(self, samplePickerView.dataSource, From, From, viewModel, pickerData);
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
