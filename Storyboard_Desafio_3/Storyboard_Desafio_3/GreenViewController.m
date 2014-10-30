//
//  GreenViewController.m
//  Storyboard_Desafio_3
//
//  Created by Alex De Souza Campelo Lima on 10/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "GreenViewController.h"
#import "OrangeViewController.h"

@interface GreenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = _green;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GoToOrange:(id)sender {
    [self performSegueWithIdentifier:@"GoToOrange" sender:self];
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToOrange"]) {
        OrangeViewController *orangeVC = (OrangeViewController*)segue.destinationViewController;
        orangeVC.orange = @"Orange";
    }
}


@end
