//
//  SampleViewController.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleViewModel.h"
#import "INavigator.h"

@interface SampleViewController : UIViewController

- (id)initWithNavigator:(id<INavigator>)navigator WithViewModel:(SampleViewModel*)viewModel;

@end
