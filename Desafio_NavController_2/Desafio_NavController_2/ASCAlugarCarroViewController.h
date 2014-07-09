//
//  ASCAlugarCarroViewController.h
//  Desafio_NavController_2
//
//  Created by Alex De Souza Campelo Lima on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAlugarCarroViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic) int currentCar;
- (IBAction)confirmarData:(id)sender;

@end
