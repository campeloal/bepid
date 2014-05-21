//
//  AppDelegate.m
//  UIScroll
//
//  Created by Alex De Souza Campelo Lima on 5/21/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:
(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //aumentando o tamanho da janela em duas vezes (largura e altura)
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    bigRect.size.height *=2.0;
    //adicionando o uiscrollview na tela.
    UIScrollView *scroolView = [[UIScrollView alloc]initWithFrame:screenRect];
    scroolView.pagingEnabled = YES;
    scroolView.scrollEnabled = NO;
    [self.window addSubview:scroolView];
    //chamando a classe principal e adicionando a variavel de scrollview no frame
    PrincipalView *hyp = [[PrincipalView alloc]initWithFrame:screenRect];
    //adicionando uma subview
    [hyp setup];
    [scroolView addSubview:hyp];
    //informando o tamanho da scrollview
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        bigRect.origin.x = scroolView.frame.size.width * i;
        bigRect.origin.y = 0;
        bigRect.size = scroolView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [scroolView addSubview:subview];
    }
    
    scroolView.contentSize = CGSizeMake(scroolView.frame.size.width * colors.count, scroolView.frame.size.height);
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
