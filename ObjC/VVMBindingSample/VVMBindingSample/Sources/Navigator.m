//
//  Navigator.m
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "Navigator.h"
#import "SampleViewController.h"
#import "Sample2ViewController.h"

@interface Navigator ()

@property (nonatomic, strong) UINavigationController* navigation;

@end

@implementation Navigator

- (id)init {
    self = [super init];
    
    if (self) {
        self.navigation = [[UINavigationController alloc] init];
    }
    
    return self;
}

- (void)showSampleView {
    SampleViewModel* viewModel = [[SampleViewModel alloc] init];
    SampleViewController* view = [[SampleViewController alloc] initWithNavigator:self WithViewModel:viewModel];
    
    [self.navigation setViewControllers:@[view]];
}

- (void)showSample2View {
    Sample2ViewController* view = [[Sample2ViewController alloc] initWithNavigator:self];
    
    [self.navigation setViewControllers:@[view]];
}

@end
