//
//  ASCViewController.m
//  Desafio_Auto_Layout
//
//  Created by Alex De Souza Campelo Lima on 7/22/14.
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
    [self checkOrientation];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self checkOrientation];
}

-(void) checkOrientation
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        _redWidthConst.constant = self.view.frame.size.height/2*0.9;
        _grayWidthConst.constant = self.view.frame.size.height/2*0.9;
        _blueWidthConst.constant = self.view.frame.size.height*0.93;
        _yellowWidthConst.constant = self.view.frame.size.height*0.72;
        
    }
    else
    {
        _redWidthConst.constant = self.view.frame.size.width/2*0.8;
        _grayWidthConst.constant = self.view.frame.size.width/2*0.8;
        _blueWidthConst.constant = self.view.frame.size.width*0.87;
        _yellowWidthConst.constant = self.view.frame.size.width*0.5;
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSize:(id)sender {
    
    if(_redHeightConst.constant == 50)
    {
        _grayHeightConst.constant = 100;
        _redHeightConst.constant = 100;
    }
    else
    {
        _redHeightConst.constant = 50;
        _grayHeightConst.constant = 50;
    }
    
    
}
@end
