//
//  UnicoAutorViewController.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Publicacao.h"

@protocol sendData <NSObject>

-(void) sendDataToPrevVC:(NSString*) data;

@end

@interface UnicoAutorViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *nomeAutor;
@property (nonatomic, retain) IBOutlet UILabel *message;
@property (nonatomic, assign) id delegate;
-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)cleanField:(id)sender;
-(IBAction)addAutor:(id)sender;

@end
