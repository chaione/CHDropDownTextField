//
//  CHAppDelegate.m
//  CHDropDownTextFieldExample
//
//  Created by Rogelio Gudino on 8/1/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import "CHAppDelegate.h"
#import "CHViewController.h"

@implementation CHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CHViewController *viewController = [[CHViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
