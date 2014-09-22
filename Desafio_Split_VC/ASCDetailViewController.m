//
//  ASCDetailViewController.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCDetailViewController.h"

@interface ASCDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *ownerField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) UIPopoverController *popover;

@end

@implementation ASCDetailViewController

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
    [self refreshInfo];
}

-(void) refreshInfo
{
    if(_item)
    {
        _nameField.text = [_item itemName];
        _serialNumberField.text = [_item serialNumber];
        _valueField.text = [NSString stringWithFormat:@"%d",[_item value]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-mm-YYYY"];
        _dateLabel.text = [formatter stringFromDate:[NSDate date]];
        _ownerField.text = [_item owner];
    }
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    //Grab a reference to the popover
    
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"Names";
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
    //Nil out the pointer to the popover.
    _popover = nil;
}

@end
