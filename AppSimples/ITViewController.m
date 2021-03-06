//
//  ITViewController.m
//  AppSimples
//
//  Created by Teste on 12/05/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ITViewController.h"

@implementation ITViewController

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
   /* [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    */
}

-(IBAction)dismissKeyboard {
    [_txtTel resignFirstResponder];
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
    [data addObject:todayData];
    
    [data writeToFile:[self saveFilePath] atomically:YES];
    
    if([self checkEnv] == YES)
    {
        _envSucesso.text = @"Enviado com sucesso";
    }
    else{
        _envSucesso.text = @"Nao foi enviado";
    }
}

-(BOOL) appendData:(NSMutableArray *)data
{
     NSDate* todayData = [[NSDate alloc] init];
    [data addObject: _txtIdade];
    [data addObject: _txtTel];
    [data addObject:todayData];
    
    return YES;
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

@end
