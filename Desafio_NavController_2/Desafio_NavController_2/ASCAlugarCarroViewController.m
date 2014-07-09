//
//  ASCAlugarCarroViewController.m
//  Desafio_NavController_2
//
//  Created by Alex De Souza Campelo Lima on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCAlugarCarroViewController.h"
#import "ASCCarCollection.h"

@interface ASCAlugarCarroViewController ()

@end

@implementation ASCAlugarCarroViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmarData:(id)sender {
    NSDate *dataFim = _datePicker.date;
    NSDate *dataInicio = [NSDate date];
    
    NSString *sDataFim = [NSDateFormatter localizedStringFromDate:dataFim dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    NSString *sDataInicio = [NSDateFormatter localizedStringFromDate:dataInicio dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    [[ASCCarCollection sharedCarCollection] setDataFim: sDataFim Index:_currentCar];
    
    [[ASCCarCollection sharedCarCollection] setDataInicio: sDataInicio Index:_currentCar];
    
    [[ASCCarCollection sharedCarCollection] setStatus:@"Alugado" Index: _currentCar];
}
@end
