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
    
    VVMBind(self, sampleLabel.text, From, From, viewModel, staticText);
    VVMBind(self, sampleTextField.text, Both, From, viewModel, editableText);
    VVMBind(self, sampleTextField.placeholder, From, From, viewModel, editableTextPlaceholder);
    
    //VVMBind(self, sampleSlider.minimumValue, Both, From, viewModel, dynamicValueMin);
    //VVMBind(self, sampleSlider.maximumValue, Both, From, viewModel, dynamicValueMax);
    //VVMBind(self, sampleSlider.value, Both, From, viewModel, dynamicValue);
    
    VVMBind(self, sampleSwitch.on, Both, From, viewModel, booleanValue);
    
    
    //VVMBind(self, samplePickerView.dataSource, Both, viewModel, pickerData);
}

- (IBAction)close:(id)sender {
    [self.navigator showSample2View];
}

@end
