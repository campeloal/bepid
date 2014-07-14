//
//  ASCAzulViewController.m
//  Desafio Table View
//
//  Created by Alex De Souza Campelo Lima on 7/14/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCAzulViewController.h"

@interface ASCAzulViewController ()

@end

@implementation ASCAzulViewController

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
    
    self.title = @"View Controller Azul 01";
    
    UIImage *image = [UIImage imageNamed:@"ciano.jpg"];
    UIImageView *ivc = [[UIImageView alloc] initWithImage:image];
    ivc.frame = CGRectMake(100,200, 100, 100);
    self.view.backgroundColor = [[UIColor alloc] initWithRed:0.165 green:0.565 blue:1.0 alpha:1.0];
    
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
