//
//  ASCViewController.h
//  Desafio_Auto_Layout
//
//  Created by Alex De Souza Campelo Lima on 7/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *grayWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowWidthConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redHeightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *grayHeightConst;

- (IBAction)changeSize:(id)sender;

@end
