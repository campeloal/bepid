//
//  UrnaViewController.h
//  ApatiaPolitica
//
//  Created by Alex De Souza Campelo Lima on 6/13/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrnaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultNumber;
@property (weak, nonatomic) IBOutlet UILabel *message;

- (IBAction)insertNumber:(id)sender;
- (IBAction)removeNumber:(id)sender;
- (IBAction)showMessage:(id)sender;

@end
