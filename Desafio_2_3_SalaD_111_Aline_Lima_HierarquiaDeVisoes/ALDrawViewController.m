//
//  DRAWViewController.m
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALDrawViewController.h"

@interface ALDrawViewController ()

@end

@implementation ALDrawViewController

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
    shapeVC = [[ALShapeViewController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goToDrawView:(id)sender
{
    
    [shapeVC setX:[_x.text floatValue]];
    [shapeVC setY:[_y.text floatValue]];
    [shapeVC setWidth:[_width.text floatValue]];
    [shapeVC setHeight:[_height.text floatValue]];
    [shapeVC setIsRect:isRect];
    [shapeVC setColor:color];
    
    [self.navigationController pushViewController:shapeVC animated:YES];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(IBAction)setColor:(id)sender
{
    UIButton *button = (UIButton*) sender;
    color = button.backgroundColor;
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
