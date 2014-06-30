//
//  ASCViewController.m
//  DesafioNavigationController
//
//  Created by Alex De Souza Campelo Lima on 7/7/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCEditViewController.h"
#import "ASCNome.h"

@interface ASCViewController ()

@end

@implementation ASCViewController

-(id) init
{
    self = [super init];
    
    if(self){
    
        UINavigationItem *navItem = self.navigationItem;
        
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style: UIBarButtonItemStylePlain target:self action:@selector(editNome:)];
        
        navItem.rightBarButtonItem = editButton;
    }
    return self;
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
    self.labelNome.text = [[ASCNome sharedNome] obterSharedNome];
    self.labelIdade.text = [NSString stringWithFormat:@"%d",[[ASCNome sharedNome] obterSharedIdade]];
    self.labelAltura.text = [NSString stringWithFormat:@"%f",[[ASCNome sharedNome] obterSharedAltura]];
    self.labelPeso.text = [NSString stringWithFormat:@"%f",[[ASCNome sharedNome] obterSharedPeso]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)editNome:(id)sender
{
    NSLog(@"clicou em edit!");
    ASCEditViewController *edit = [[ASCEditViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}



@end
