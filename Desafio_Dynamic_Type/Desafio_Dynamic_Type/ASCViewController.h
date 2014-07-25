//
//  ASCViewController.h
//  Desafio_Dynamic_Type
//
//  Created by Alex De Souza Campelo Lima on 7/25/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UIButton *bt4;
@property (weak, nonatomic) IBOutlet UIButton *bt5;
@property (weak, nonatomic) IBOutlet UIButton *bt6;
- (IBAction)changeFontStyle:(id)sender;

@end
