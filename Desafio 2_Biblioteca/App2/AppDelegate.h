//
//  AppDelegate.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LibViewController *lvc;
}
@property (strong, nonatomic) UIWindow *window;

@end
