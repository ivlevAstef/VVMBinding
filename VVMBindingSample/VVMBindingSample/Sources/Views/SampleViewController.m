//
//  SampleViewController.m
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SampleViewController.h"
#import "VVMBinding/VVMBinding.h"

@interface SampleViewController ()

@property (weak, nonatomic) IBOutlet UILabel* sampleLabel;
@property (weak, nonatomic) IBOutlet UITextField* sampleTextField;
@property (weak, nonatomic) IBOutlet UISlider* sampleSlider;
@property (weak, nonatomic) IBOutlet UISwitch* sampleSwitch;
@property (weak, nonatomic) IBOutlet UIPickerView* samplePickerView;

@property (nonatomic, strong) SampleViewModel* viewModel;

@end

@implementation SampleViewController

- (id)initWithViewModel:(SampleViewModel*)viewModel {
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
        [self bind:viewModel];
    }
    
    return self;
}

- (void)bind:(SampleViewModel*)viewModel {
    VVMBind(self, sampleLabel.text, From, viewModel, staticText);
    VVMBind(self, sampleTextField.text, Both, viewModel, editableText);
    
    VVMBind(self, sampleSlider.value, Both, viewModel, dynamicValue);
    VVMBind(self, sampleSlider.minimumValue, Both, viewModel, dynamicValueMin);
    VVMBind(self, sampleSlider.maximumValue, Both, viewModel, dynamicValueMax);
    
    VVMBind(self, sampleSwitch.on, Both, viewModel, booleanValue);
    
    //VVMBind(self, samplePickerView.dataSource, Both, viewModel, pickerData);
}

/*
- (void)VVMMNotChangesSampleSwitchIsOnTo:(id)NewValue {
    self.sampleSwitch set
}
*/

@end
