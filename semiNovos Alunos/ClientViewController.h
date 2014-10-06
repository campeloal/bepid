//
//  ClientViewController.h
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientCarViewController.h"

@class Client;

@interface ClientViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property Client *client;

- (IBAction)dismissKeyboard:(id)sender;

@end
