//
//  ASCEditViewController.m
//  DesafioNavigationController
//
//  Created by Alex De Souza Campelo Lima on 7/7/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCEditViewController.h"
#import "ASCNome.h"

@interface ASCEditViewController ()

@end

@implementation ASCEditViewController

-(id) init
{
    self = [super init];
    
    if(self)
    {
        UINavigationItem *navEditItem = self.navigationItem;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style: UIBarButtonItemStylePlain target:self action:@selector(editDone:)];
        
        navEditItem.rightBarButtonItem = doneButton;
    }
    
    return  self;
}

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

-(void) viewWillAppear:(BOOL)animated
{
    self.campoNome.text = [[ASCNome sharedNome] obterSharedNome];
    self.campoAltura.text = [NSString stringWithFormat:@"%f", [[ASCNome sharedNome] obterSharedAltura]];
    self.campoPeso.text = [NSString stringWithFormat:@"%f", [[ASCNome sharedNome] obterSharedPeso]];
    self.campoIdade.text = [NSString stringWithFormat:@"%d", [[ASCNome sharedNome] obterSharedIdade]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)editDone:(id)sender
{
    [[ASCNome sharedNome] setarSharedNome: self.campoNome.text];
    [[ASCNome sharedNome] setarSharedIdade: [self.campoIdade.text intValue]];
    [[ASCNome sharedNome] setarSharedPeso: [self.campoPeso.text floatValue]];
    [[ASCNome sharedNome] setarSharedAltura: [self.campoAltura.text floatValue]];
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
