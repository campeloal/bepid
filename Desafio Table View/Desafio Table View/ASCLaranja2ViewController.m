//
//  ASCLaranja2ViewController.m
//  Desafio Table View
//
//  Created by Alex De Souza Campelo Lima on 7/14/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCLaranja2ViewController.h"

@interface ASCLaranja2ViewController ()

@end

@implementation ASCLaranja2ViewController

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
    
    self.title = @"View Controller Laranja 02";
    
    UIImage *image = [UIImage imageNamed:@"holanda.gif"];
    UIImageView *ivc = [[UIImageView alloc] initWithImage:image];
    ivc.frame = CGRectMake(100,200, 100, 100);
    self.view.backgroundColor = [UIColor orangeColor];
    
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
