//
//  AlphaViewController.m
//  Storyboard_Desafio_2
//
//  Created by Alex De Souza Campelo Lima on 10/27/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "AlphaViewController.h"
#import "BetaViewController.h"

@interface AlphaViewController ()
@property (weak, nonatomic) IBOutlet UIButton *next;

@end

@implementation AlphaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextViewController:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Beta" bundle:nil];
    
    BetaViewController *bvc = (BetaViewController *) [storyboard instantiateViewControllerWithIdentifier:@"Beta"];
    
    [self presentViewController:bvc animated:nil completion:nil];
   
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
