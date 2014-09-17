//
//  ASCDetailViewController.h
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCItem.h"

@interface ASCDetailViewController : UIViewController <UITextFieldDelegate,UISplitViewControllerDelegate>

@property (nonatomic) ASCItem* item;

-(void) refreshInfo;

@end
