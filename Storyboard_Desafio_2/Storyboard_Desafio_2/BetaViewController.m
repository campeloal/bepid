//
//  BetaViewController.m
//  Storyboard_Desafio_2
//
//  Created by Alex De Souza Campelo Lima on 10/27/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BetaViewController.h"
#import "AlphaViewController.h"

@interface BetaViewController ()
@property (weak, nonatomic) IBOutlet UIButton *before;

@end

@implementation BetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextViewController:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Alfa" bundle:nil];
    
    AlphaViewController *avc = (AlphaViewController *) [storyboard instantiateViewControllerWithIdentifier:@"Alpha"];
    
    [self presentViewController:avc animated:nil completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
