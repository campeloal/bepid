//
//  LibViewController.m
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "LibViewController.h"

@interface LibViewController ()

@end

@implementation LibViewController

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
    isBook = YES;
    avc = [[AutorTableViewController alloc] init];
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

-(void) createBook
{
    book = [[NSMutableArray alloc] init];
    [book addObject:_titulo.text];
    [book addObject:_isbn.text];
    [book addObject:_registro.text];
}

-(IBAction)saveBook:(id)sender
{
    if(book == nil && ([self checkFieldIsEmpty] == NO))
    {
        [self createBook];
    }
    
    if(([self checkFieldIsEmpty] == NO) && ([self checkFormat] == YES) && (pb == nil))
    {
        pb = [Publicacao sharedPublicacao];
        [pb addPublicacao:book];
        [pb savePublication];
    }
}

-(void) printData
{
    [pb checkPublication];
}

-(BOOL) checkFormat
{
    if([self checkBookPeriodic] == YES)
    {
        _error_message.text = @"";
        return YES;
    }
    else
    {
        _error_message.text = @"*o formato do registro está errado";
        return NO;
    }
}

-(BOOL) checkBookPeriodic
{
    if(isBook == YES)
    {
        return [self registerFilter:@"L"];
    }
    else
    {
        return [self registerFilter:@"P"];
    }
}

-(BOOL) checkFieldIsEmpty
{
    if(([_titulo.text isEqualToString:@"Insira título"]) || ([_registro.text isEqualToString:@"Insira registro"]) ||
                                                 /*([_autores.text isEqualToString:@"Insira autor"]) || */
                                                 ([_isbn.text isEqualToString:@"Insira isbn"]))
    {
        _error_message.text = @"*os campos não podem estar vazios";
        return YES;
    }
    return  NO;
}

-(BOOL) registerFilter:(NSString*) publicationType
{
    NSString* mask = [NSString stringWithFormat:@"%@%@%@",@"([",publicationType,@"]\\d{4}[\\/]\\d{4})"];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:mask
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSString *registroText = _registro.text;
    NSArray *matches = [regex matchesInString:registroText
                                      options:0
                                        range:NSMakeRange(0, [registroText length])];
    if([matches count] == 1)
    {
        return YES;
    }
    else
    {
        return NO;
    }

}

- (IBAction)chooseBookPeriodic:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        isBook = YES;
    }
    else{
        isBook = NO;
    }
}

-(IBAction)goToAutorController:(id)sender
{
    [self.navigationController pushViewController:avc animated:YES];
}

-(IBAction)cleanField:(id)sender
{
    UITextField *tf = (UITextField*) sender;
    tf.text = @"";
}

@end
