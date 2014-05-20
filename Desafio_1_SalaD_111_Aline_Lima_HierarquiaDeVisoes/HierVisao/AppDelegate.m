//
//  AppDelegate.m
//  HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "AppDelegate.h"
#import "TESView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];   
    
    CGRect orangeFrame = CGRectMake(0, 0, 100, 100);
    TESView *orangeView = [[TESView alloc] initWithFrame:orangeFrame];
    orangeView.layer.borderWidth = 3;
    orangeView.layer.borderColor = [UIColor blackColor].CGColor;
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.window addSubview:orangeView];
    
    CGRect greenFrame = CGRectMake(10, 10, 60, 40);
    TESView *greenView = [[TESView alloc] initWithFrame:greenFrame];
    greenView.layer.borderWidth = 3;
    greenView.layer.borderColor = [UIColor blackColor].CGColor;
    greenView.backgroundColor = [UIColor greenColor];
    [orangeView addSubview:greenView];
    
    float rightCornerW = (float) self.window.bounds.size.width;
    float rightCornerH = (float) self.window.bounds.size.height;
    
    CGRect grayFrame = CGRectMake(rightCornerW - 100, rightCornerH - 100, 100, 100);
    TESView *grayView = [[TESView alloc] initWithFrame:grayFrame];
    grayView.layer.borderWidth = 3;
    grayView.layer.borderColor = [UIColor blackColor].CGColor;
    grayView.backgroundColor = [UIColor grayColor];
    [self.window addSubview:grayView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
