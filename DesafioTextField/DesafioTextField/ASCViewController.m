//
//  ASCViewController.m
//  DesafioTextField
//
//  Created by Teste on 25/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCFormulario.h"

@interface ASCViewController ()
{
    ASCFormulario *formulario;
    BOOL enviado;
}

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _senha.secureTextEntry = YES;
    _senha.enablesReturnKeyAutomatically = YES;
    _cpf.enablesReturnKeyAutomatically = YES;
    _cpf.keyboardType = UIKeyboardTypePhonePad;
    _telefone.keyboardType = UIKeyboardTypePhonePad;
    _nome.enablesReturnKeyAutomatically = YES;
    _nome.autocapitalizationType = YES;
    _nome.keyboardType = UIKeyboardTypeNamePhonePad;
    
    formulario = [[ASCFormulario alloc] init];
    enviado = NO;
    _nome.text = @"";
    _cpf.text = @"";
    _telefone.text = @"";
    _senha.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enviarDados:(id)sender
{
    if((![_nome.text isEqual: @""]) && (![_cpf.text isEqual: @""]) && (![_senha.text isEqual: @""]))
    {
        [self salvarDados];
        enviado = YES;
        [self mostrarPopUpMensagem:@"Confirmação" Titulo:@"Dados enviados com sucesso"];
    }
    else
    {
        [self mostrarPopUpMensagem:@"Não enviado" Titulo:@"Algum campo (exceto telefone) está em branco"];
    }
}

-(void) salvarDados
{
    [formulario adicionarDadosNome:_nome.text Cpf:[_cpf.text intValue] Tel:[_telefone.text intValue] Senha:[_senha.text intValue]];
    [formulario salvarFormulario];
}

-(void) mostrarPopUpMensagem: (NSString *) mensagem Titulo: (NSString*) titulo
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titulo message:mensagem delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if((buttonIndex == 0) && (enviado == YES))
    {
       _nome.text = @"";
       _senha.text = @"";
       _cpf.text = @"";
       _telefone.text = @"";
        enviado = NO;
    }
    
}

- (IBAction)sumirTeclado:(id)sender {
    [self.view endEditing:YES];
}
@end
