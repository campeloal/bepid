//
//  ITViewController.m
//  AppSimples
//
//  Created by Teste on 12/05/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "DataViewController.h"

@implementation DataViewController

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
    _btInsert.hidden = YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.isMovingToParentViewController == NO)
    {
        if(_envSucesso == YES)
        {
            _btInsert.hidden = NO;
        }
    }
}

-(IBAction)dismissKeyboard {
    [_txtTel resignFirstResponder];
    [_txtNome resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtCurso resignFirstResponder];
    [_txtUni resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)updateAge:(id)sender
{
    
    NSString *newText = [NSString stringWithFormat:@"%d", (int)_slider.value];
    _txtIdade.text = newText;
    
}

-(NSString*)saveFilePath
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"historico.plist"];
}

-(IBAction)saveData:(id)sender
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSDate* todayData = [[NSDate alloc] init];
    [data addObject: _txtIdade.text];
    [data addObject: _txtTel.text];
    [data addObject:_txtNome.text];
    [data addObject:_txtCurso.text];
    [data addObject:_txtUni.text];
    [data addObject:_txtEmail.text];
    [data addObject:todayData];
    
    [data writeToFile:[self saveFilePath] atomically:YES];
    
    if([self checkEnv] == YES)
    {
        _envSucesso = YES;
        [self switchToNewView:sender];
    }
    else{
        _envSucesso = NO;
    }
}


-(BOOL) checkEnv
{
    NSArray *files = [[NSArray alloc] initWithContentsOfFile: [self saveFilePath]];
    if([files[0] isEqualToString:_txtIdade.text])
    {
        return YES;
    }
    return NO;
}

-(BOOL) shouldAutorotate
{
    return NO;
}

-(IBAction)cleanFields:(id)sender
{
    _txtNome.text = @"Insira o nome";
    _slider.value = 39;
    _txtIdade.text = @"39";
    _txtCurso.text = @"Insira o curso";
    _txtEmail.text = @"Insira o e-mail";
    _txtTel.text = @"33333333";
    _txtUni.text = @"Insira universidade";
}

-(IBAction)switchToNewView:(id)sender
{
    ConfirmationViewController *newViewController =
    [[ConfirmationViewController alloc]
     init];
    
    [self presentViewController:newViewController animated:YES completion:nil];
    //
    //        UINavigationController *navigation = [[UINavigationController alloc]
    //                            initWithRootViewController:newViewController];
    //
    //        [[[UIApplication sharedApplication] keyWindow] addSubview:[navigation view]];
}

@end
