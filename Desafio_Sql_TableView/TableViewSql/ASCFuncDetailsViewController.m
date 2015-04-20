//
//  ASCFuncDetailsViewController.m
//  TableViewSql
//
//  Created by Alex De Souza Campelo Lima on 7/17/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "ASCFuncDetailsViewController.h"

@interface ASCFuncDetailsViewController ()

@end

@implementation ASCFuncDetailsViewController

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
    self.salary.text = self.salaryText;
    self.year.text = self.yearText;
    self.month.text = self.monthText;
    self.photo.image = [UIImage imageNamed:self.photoText];
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
