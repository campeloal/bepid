//
//  UnicoAutorViewController.m
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "UnicoAutorViewController.h"

@interface UnicoAutorViewController ()

@end

@implementation UnicoAutorViewController

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

-(void) viewWillDisappear:(BOOL)animated
{
    [_delegate sendDataToPrevVC:_nomeAutor.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(IBAction)addAutor:(id)sender
{
    Publicacao *pb = [Publicacao sharedPublicacao];
    if((![_nomeAutor.text isEqualToString: @"Insira nome"]) && (![_nomeAutor.text isEqualToString: @""]))
    {
        [pb addAutor:_nomeAutor.text];
        [_message setTextColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]];
        _message.text = @"enviado";
        
    }
    else
    {
        [_message setTextColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]];
        _message.text = @"campo vazio";
    }
}

-(IBAction)cleanField:(id)sender
{
    UITextField *tf = (UITextField*) sender;
    tf.text = @"";
}

@end
