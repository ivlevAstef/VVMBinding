//
//  Sample2ViewController.m
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 10/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "Sample2ViewController.h"

@interface Sample2ViewController ()

@property (nonatomic, strong) id<INavigator> navigator;

@end

@implementation Sample2ViewController


- (id)initWithNavigator:(id<INavigator>)navigator {
    self = [super init];
    
    if (self) {
        self.navigator = navigator;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
