//
//  DRAWViewController.m
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "DRAWViewController.h"

@interface DRAWViewController ()

@end

@implementation DRAWViewController

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
    // Do any additional setup after loading the view from its nib.
    color = [UIColor blackColor];
    isRect = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goToDrawView:(id)sender
{
    [self createNewView];
    [self.navigationController pushViewController:rectVC animated:YES];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(void) createNewView
{
//    CGRect frame = CGRectMake([self.x.text floatValue], [self.y.text floatValue], [self.width.text floatValue], [self.height.text floatValue]);
//    rectVC = [[RECTViewController alloc] init];
//    rectView = [[RECTView alloc] initWithFrame:frame];
//    rectView.backgroundColor = color;
//    [rectVC.view addSubview:rectView];
    
    
    rectVC = [[RECTViewController alloc] init];
    eliView = [[ELIView alloc] init];
    //eliView.backgroundColor = color;
    [rectVC.view addSubview:eliView];
}


-(IBAction)drawGreen:(id)sender
{
    color = [UIColor greenColor];
}

-(IBAction)drawYellow:(id)sender
{
    color = [UIColor yellowColor];
}

-(IBAction)drawBlue:(id)sender
{
    color = [UIColor blueColor];
}

-(IBAction)drawRed:(id)sender
{
    color = [UIColor redColor];
}

-(IBAction)drawBlack:(id)sender
{
    color = [UIColor blackColor];
}

- (IBAction)chooseForm:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        isRect = YES;
    }
    else{
        isRect = NO;
    }
}




@end
