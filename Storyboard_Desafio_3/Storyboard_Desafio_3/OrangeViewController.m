//
//  OrangeViewController.m
//  Storyboard_Desafio_3
//
//  Created by Alex De Souza Campelo Lima on 10/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "OrangeViewController.h"
#import "BlueViewController.h"

@interface OrangeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation OrangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = _orange;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GoToBlue:(id)sender {
    [self performSegueWithIdentifier:@"GoToBlue" sender:self];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToBlue"]) {
        BlueViewController *blueVC = (BlueViewController*)segue.destinationViewController;
        blueVC.blue = @"Blue";
    }
}


@end
