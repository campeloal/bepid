//
//  DRAWViewController.h
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALShapeViewController.h"

@interface ALDrawViewController : UIViewController
{
    ALShapeViewController *shapeVC;
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
-(IBAction)setColor:(id)sender;

@end
