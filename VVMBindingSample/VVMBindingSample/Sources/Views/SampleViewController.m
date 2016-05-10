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
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bind:self.viewModel];
}

- (void)bind:(SampleViewModel*)viewModel {
    VVMBind(self, sampleLabel.text, From, From, viewModel, staticText);
    VVMBind(self, sampleTextField.text, Both, From, viewModel, editableText);
    VVMBind(self, sampleTextField.placeholder, Both, From, viewModel, editableTextPlaceholder);
    
    VVMBind(self, sampleSlider.minimumValue, Both, From, viewModel, dynamicValueMin);
    VVMBind(self, sampleSlider.maximumValue, Both, From, viewModel, dynamicValueMax);
    VVMBind(self, sampleSlider.value, Both, From, viewModel, dynamicValue);
    
    VVMBind(self, sampleSwitch.on, Both, From, viewModel, booleanValue);
    
    /*[VVMObject(self, sampleTextField.text) check:^(id NewValue) {
        
    }];
    
    [VVMObject(self, sampleTextField.text) transformation:^(id NewValue) {
        
    }];
    
    [VVMObject(self, sampleTextField.text) update:^(id NewValue) {
        
    }];
    */
    //VVMBind(self, samplePickerView.dataSource, Both, viewModel, pickerData);
}

/*
- (void)VVMMNotChangesSampleSwitchIsOnTo:(id)NewValue {
    self.sampleSwitch set
}
*/

@end
