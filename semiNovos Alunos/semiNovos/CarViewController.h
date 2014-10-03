//
//  CarViewController.h
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

@interface CarViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property Car *car;

@end
