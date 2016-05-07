//
//  Navigator.h
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Navigator : NSObject

@property (nonatomic, readonly) UINavigationController* navigation;

- (void)showSampleView;

@end
