//
//  ITViewController.h
//  AppSimples
//
//  Created by Teste on 12/05/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITViewController : UIViewController


@property(nonatomic,retain) IBOutlet UITextField *txtIdade;
@property(nonatomic,retain) IBOutlet UITextField *envSucesso;
@property(nonatomic,retain) IBOutlet UISlider *slider;
@property(nonatomic,retain) IBOutlet UITextField *txtTel;

- (IBAction) updateAge:(id) sender;
- (IBAction) saveData:(id)sender;
- (BOOL) checkEnv;
- (NSString*) saveFilePath;
-(void) dismissKeyboard;

@end
