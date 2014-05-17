//
//  LibViewController.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Publicacao.h"
#import "AutorTableViewController.h"

@interface LibViewController : UIViewController
{
    Publicacao *pb;
    NSMutableArray *book;
    BOOL isBook;
}

@property (nonatomic, retain) IBOutlet UITextField *titulo;
@property (nonatomic, retain) IBOutlet UITextField *autores;
@property (nonatomic, retain) IBOutlet UITextField *isbn;
@property (nonatomic, retain) IBOutlet UITextField *registro;
@property (nonatomic, retain) IBOutlet UILabel *error_message;
@property (nonatomic, retain) IBOutlet UIButton *enviar;

-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)saveBook:(id)sender;
-(IBAction)chooseBookPeriodic:(id)sender;
-(IBAction)goToAutorController:(id)sender;
-(IBAction)cleanField:(id)sender;
-(void) printData;
-(void) createBook;
-(BOOL) checkFormat;

@end
