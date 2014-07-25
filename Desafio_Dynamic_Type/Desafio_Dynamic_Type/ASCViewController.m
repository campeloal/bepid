//
//  ASCViewController.m
//  Desafio_Dynamic_Type
//
//  Created by Alex De Souza Campelo Lima on 7/25/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"

@interface ASCViewController ()
{
    NSString* _fontStyle;
}

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _fontStyle = UIFontTextStyleHeadline;
    [self updateFont];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateFontFromSystem)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}


-(void) updateFont
{
    _text.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt1.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt2.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt3.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt4.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt5.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
    _bt6.titleLabel.font = [UIFont preferredFontForTextStyle:_fontStyle];
}

-(void) updateFontFromSystem
{
    _fontStyle = [[UIApplication sharedApplication] preferredContentSizeCategory];
    
    [self updateFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changeFontStyle:(id)sender {
    
    if(sender == _bt1)
    {
        _fontStyle = UIFontTextStyleHeadline;
    }
    else if (sender == _bt2)
    {
        _fontStyle = UIFontTextStyleSubheadline;
    }
    else if (sender == _bt3)
    {
        _fontStyle = UIFontTextStyleBody;
    }
    else if (sender == _bt4)
    {
        _fontStyle = UIFontTextStyleFootnote;
    }
    else if (sender == _bt5)
    {
        _fontStyle = UIFontTextStyleCaption1;
    }
    else
    {
        _fontStyle = UIFontTextStyleCaption2;
    }
    
    [self updateFont];
}
@end
