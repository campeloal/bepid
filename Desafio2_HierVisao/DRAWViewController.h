//
//  DRAWViewController.h
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RECTViewController.h"
#import "ELIViewController.h"
#import "RECTView.h"
#import "ELIView.h"

@interface DRAWViewController : UIViewController
{
    RECTViewController *rectVC;
    RECTView *rectView;
    
    ELIView *eliView;
    UIColor *color;
    BOOL isRect;
}

@property (nonatomic, retain) IBOutlet UITextField *x;
@property (nonatomic, retain) IBOutlet UITextField *y;
@property (nonatomic, retain) IBOutlet UITextField *width;
@property (nonatomic, retain) IBOutlet UITextField *height;

-(IBAction)goToDrawView:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;
- (IBAction)chooseForm:(id)sender;
-(IBAction)drawGreen:(id)sender;
-(IBAction)drawYellow:(id)sender;
-(IBAction)drawBlue:(id)sender;
-(IBAction)drawRed:(id)sender;
-(IBAction)drawBlack:(id)sender;

@end
