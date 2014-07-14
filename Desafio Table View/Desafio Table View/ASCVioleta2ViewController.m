//
//  ASCVioleta2ViewController.m
//  Desafio Table View
//
//  Created by Alex De Souza Campelo Lima on 7/14/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCVioleta2ViewController.h"

@interface ASCVioleta2ViewController ()

@end

@implementation ASCVioleta2ViewController

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
    // Do any additional setup after loading the view.
    
    self.title = @"View Controller Violeta 02";
    
    UIImage *image = [UIImage imageNamed:@"violeta.jpg"];
    UIImageView *ivc = [[UIImageView alloc] initWithImage:image];
    ivc.frame = CGRectMake(100,200, 100, 100);
    self.view.backgroundColor = [[UIColor alloc] initWithRed:1.0 green:0.25 blue:0.957 alpha:1.0];
    
    [self.view addSubview: ivc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
