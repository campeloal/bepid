//
//  BPDCreateTabViewController.m
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BPDCreateTabViewController.h"
#import "BPDNewTabViewController.h"
#import "BPDImage.h"

@interface BPDCreateTabViewController ()

@end

@implementation BPDCreateTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Create";
        UIImage *image = [UIImage imageNamed:@"view2.png"];
        self.tabBarItem.image = [BPDImage imageWithImage: image scaledToSize:CGSizeMake(20, 20)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createNewTab:(id)sender {
    
    BPDNewTabViewController *newTab = [[BPDNewTabViewController alloc] init];
    
    NSArray *currentControllers = self.tabBarController.viewControllers;
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    [newControllers addObject:newTab];
    
    [self.tabBarController setViewControllers:newControllers
                                     animated:YES];
   
    [self.tabBarController setSelectedIndex:(newControllers.count -1)];
    
    [_delegate changeInfo: newTab.tabBarItem.title];
    
}

@end
