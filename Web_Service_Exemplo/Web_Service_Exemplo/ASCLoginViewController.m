//
//  ASCLoginViewController.m
//  Web_Service_Exemplo
//
//  Created by Alex De Souza Campelo Lima on 9/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCLoginViewController.h"
#import "ASCMainScreenViewController.h"

@interface ASCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ASCLoginViewController

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
    _password.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendLogin:(id)sender {
    
    if ([_user.text isEqualToString:@""] && [_password.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Acesso Falhou!" message:@"Favor, entre com usuário e senha" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    else if (!([_user.text isEqualToString:@"usuario"]) || !([_password.text isEqualToString:@"senha"])) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Acesso Falhou!" message:@"Usuário e/ou senha inválidos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    else
    {
        [self presentViewController:[[ASCMainScreenViewController alloc] init] animated:YES completion:nil];
    }
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
