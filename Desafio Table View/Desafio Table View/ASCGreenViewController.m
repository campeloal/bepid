//
//  ASCGreenViewController.m
//  Desafio Table View
//
//  Created by Alex De Souza Campelo Lima on 7/14/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCGreenViewController.h"

@interface ASCGreenViewController ()

@end

@implementation ASCGreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"View Controller Verde 01";
    
    UIImage *image = [UIImage imageNamed:@"palmeiras.png"];
    UIImageView *ivc = [[UIImageView alloc] initWithImage:image];
    ivc.frame = CGRectMake(100,200, 100, 100);
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.36 blue:0.0 alpha:1.0];
    
    [self.view addSubview: ivc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
