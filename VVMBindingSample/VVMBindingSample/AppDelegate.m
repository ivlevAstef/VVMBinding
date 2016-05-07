//
//  AppDelegate.m
//  VVMBindingSample
//
//  Created by Alexander Ivlev on 06/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "AppDelegate.h"
#import "Navigator.h"

@interface AppDelegate ()

@property (strong, nonatomic) Navigator* navigator;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    self.navigator = [Navigator new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigator.navigation;
    [self.window makeKeyAndVisible];
    
    [self.navigator showSampleView];
    
    return YES;
}

@end
