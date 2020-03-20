//
//  AppDelegate.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ABViewController * viewController = [[ABViewController alloc] init];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    _window.rootViewController = navigationController;
    
    return YES;
}



@end
