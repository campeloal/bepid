//
//  ASCAppDelegate.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCDetailViewController.h"
#import "ASCTableViewController.h"
#import "ASCItemStore.h"

@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ASCDetailViewController *dvc = [[ASCDetailViewController alloc] init];
    ASCTableViewController *tvc = [[ASCTableViewController alloc] init];
    
    tvc.detailViewController = dvc;
    
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:tvc];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:dvc];
        
        UISplitViewController *splitVC = [[UISplitViewController alloc] init];
        splitVC.delegate = dvc;
        splitVC.viewControllers = @[masterNav, detailNav];
        
        self.window.rootViewController = splitVC;
    }
    else
    {
        self.window.rootViewController = masterNav;
    }
    
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
    BOOL success = [[ASCItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the ASCItems");
    }else
    {
        NSLog(@"Could not save any of the ASCItems");
    }
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
