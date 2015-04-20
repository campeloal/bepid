//
//  ITViewController.h
//  AppSimples
//
//  Created by Teste on 12/05/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmationViewController.h"

@interface DataViewController : UIViewController


@property(nonatomic,retain) IBOutlet UITextField *txtIdade;
@property(nonatomic,retain) IBOutlet UITextField *txtNome;
@property(nonatomic,retain) IBOutlet UITextField *txtEmail;
@property(nonatomic,retain) IBOutlet UITextField *txtUni;
@property(nonatomic,retain) IBOutlet UITextField *txtCurso;
@property(nonatomic,retain) IBOutlet UISlider *slider;
@property(nonatomic,retain) IBOutlet UITextField *txtTel;
@property(nonatomic,retain) IBOutlet UIButton *btInsert;
@property(nonatomic) BOOL envSucesso;

- (IBAction) updateAge:(id) sender;
- (IBAction) saveData:(id)sender;
- (BOOL) checkEnv;
- (NSString*) saveFilePath;
-(IBAction) dismissKeyboard;
-(IBAction)cleanFields:(id)sender;
-(IBAction)switchToNewView:(id)sender;

@end
