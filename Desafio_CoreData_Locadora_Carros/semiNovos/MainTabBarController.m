//
//  MainTabBarController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/29/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "MainTabBarController.h"
#import "CreateDelegate.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addItem:(id)sender {
    UIViewController <CreateDelegate> *a = (UIViewController <CreateDelegate> *)self.selectedViewController;
    [a createItem];
}

@end
