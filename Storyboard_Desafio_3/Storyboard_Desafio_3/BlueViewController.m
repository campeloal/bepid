//
//  ViewController.m
//  Storyboard_Desafio_3
//
//  Created by Alex De Souza Campelo Lima on 10/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BlueViewController.h"
#import "GreenViewController.h"

@interface BlueViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleLabel.text = _blue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToGreen:(id)sender {
    [self performSegueWithIdentifier:@"GoToGreen" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToGreen"]) {
        GreenViewController *greenVC = (GreenViewController*)segue.destinationViewController;
        greenVC.green = @"Green";
    }
}

@end
