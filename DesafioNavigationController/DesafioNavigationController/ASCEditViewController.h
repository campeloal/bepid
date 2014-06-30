//
//  ASCEditViewController.h
//  DesafioNavigationController
//
//  Created by Alex De Souza Campelo Lima on 7/7/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *campoNome;
@property (weak, nonatomic) IBOutlet UITextField *campoIdade;
@property (strong, nonatomic) IBOutlet UITextField *campoAltura;
@property (weak, nonatomic) IBOutlet UITextField *campoPeso;

@end
