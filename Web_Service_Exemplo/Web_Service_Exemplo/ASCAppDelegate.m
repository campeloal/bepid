//
//  ASCAppDelegate.m
//  Web_Service_Exemplo
//
//  Created by Alex De Souza Campelo Lima on 9/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCLoginViewController.h"
#import "ASCMainScreenViewController.h"


@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self checkLogin];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) checkLogin
{
    NSInteger success = 0;
    _ip = @"172.16.1.52";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *post = [[NSString alloc] initWithFormat:@"username=%@&password=%@",[prefs stringForKey:@"username"],[prefs stringForKey:@"password"]];
    
    NSLog(@"PostData: %@",post);
    
    NSString* address = [NSString stringWithFormat:@"http://%@:8888/jsonlogin.php", _ip];
    
    NSURL *url = [NSURL URLWithString:address];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength
   forHTTPHeaderField: @"Content-Length"];
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //NSLog(@"error %@", error);
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        
        NSString *responseData = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error: &error];
        
        success = [jsonData[@"success"] integerValue];
        
        NSLog(@"success: %ld", (long) success);
        
        if (success == 1) {
            NSLog(@"Login SUCESS");
            _nav = [[UINavigationController alloc] initWithRootViewController:[[ASCMainScreenViewController alloc] init]];
            self.window.rootViewController = _nav;
            
        }
        else
        {
           ASCLoginViewController *login = [[ASCLoginViewController alloc] init];
           login.ip = _ip;
            _nav = [[UINavigationController alloc] initWithRootViewController:login];
            self.window.rootViewController = _nav;
        }
        
    }
    else
    {
        ASCLoginViewController *login = [[ASCLoginViewController alloc] init];
        login.ip = _ip;
        _nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = _nav;
        
//        _nav = [[UINavigationController alloc] initWithRootViewController:[[ASCMainScreenViewController alloc] init]];
//        self.window.rootViewController = _nav;
    }
    
    
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
