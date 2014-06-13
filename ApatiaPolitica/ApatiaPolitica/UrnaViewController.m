//
//  UrnaViewController.m
//  ApatiaPolitica
//
//  Created by Alex De Souza Campelo Lima on 6/13/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "UrnaViewController.h"
#import "Mensagem.h"

@interface UrnaViewController ()
{
    Mensagem *mes;
}
@end

@implementation UrnaViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insertNumber:(id)sender {
    
    if([_resultNumber.text isEqual:@""])
    {
        _resultNumber.text = [(UIButton*) sender currentTitle];
    }
    // It's including the number and the spaces
    else if([_resultNumber.text length] < 9)
    {
    
        _resultNumber.text = [NSString stringWithFormat:@"%@ %@", _resultNumber.text, [(UIButton*) sender currentTitle]];
    }
}

-(IBAction)removeNumber:(id)sender {
    
    int resultSize = (int) [_resultNumber.text length];
    if(resultSize > 0)
    {
        if(resultSize == 1)
        {
            _resultNumber.text = [_resultNumber.text substringToIndex:[_resultNumber.text length] - 1];
        }
        else
        {
            _resultNumber.text = [_resultNumber.text substringToIndex:[_resultNumber.text length] - 2];
        }
    }
}

- (IBAction)showMessage:(id)sender {
    _message.text = [mes randomizeMessages];
    NSLog(@"%@", [mes randomizeMessages]);
}
@end
