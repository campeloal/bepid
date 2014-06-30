//
//  BPDNewTabViewController.m
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 7/1/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BPDNewTabViewController.h"
#import "BPDImage.h"

@interface BPDNewTabViewController ()

@end

@implementation BPDNewTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"New";
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

@end
