//
//  ASCViewController.h
//  DesafioTextField
//
//  Created by Teste on 25/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cpf;
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *senha;

- (IBAction)enviarDados:(id)sender;
- (IBAction)sumirTeclado:(id)sender;

@end
