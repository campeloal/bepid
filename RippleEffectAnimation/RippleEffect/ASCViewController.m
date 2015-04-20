//
//  ASCViewController.m
//  RippleEffect
//
//  Created by Alex De Souza Campelo Lima on 8/6/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"

@interface ASCViewController ()

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    int rippleDiameter = self.view.frame.size.width/2;
    UIView *ripple = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - rippleDiameter/2, self.view.center.y - rippleDiameter/2, rippleDiameter, rippleDiameter)];
    [ripple setBackgroundColor:[UIColor grayColor]];
    [ripple.layer setCornerRadius:ripple.bounds.size.height /2]; //Assuming square images
    ripple.alpha = 0.1;
    [self.view addSubview:ripple];
    
    rippleDiameter -= 50;
    UIView *ripple2 = [[UIView alloc] initWithFrame:CGRectMake(ripple.center.x - rippleDiameter/2, ripple.center.y - rippleDiameter/2, rippleDiameter, rippleDiameter)];
    [ripple2 setBackgroundColor:[UIColor grayColor]];
    [ripple2.layer setCornerRadius:ripple2.bounds.size.height /2]; //Assuming square images
    ripple2.alpha = 0.1;
    [self.view addSubview:ripple2];
    
    
    rippleDiameter -= 50;
    UIView *ripple3 = [[UIView alloc] initWithFrame:CGRectMake(ripple.center.x - rippleDiameter/2, ripple.center.y - rippleDiameter/2, rippleDiameter, rippleDiameter)];
    [ripple3 setBackgroundColor:[UIColor grayColor]];
    [ripple3.layer setCornerRadius:ripple3.bounds.size.height /2]; //Assuming square images
    ripple3.alpha = 0.1;
    [self.view addSubview:ripple3];
    
    
    
    [UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionTransitionNone animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        ripple.transform = CGAffineTransformMakeScale(2, 2);
        ripple2.transform = CGAffineTransformMakeScale(2, 2);
        ripple3.transform = CGAffineTransformMakeScale(2, 2);
    }  completion:nil ];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
