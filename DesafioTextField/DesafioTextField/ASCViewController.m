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
    BOOL isCPF;
    NSString* cancelInfo;
}

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _senha.secureTextEntry = YES;
    _senha.returnKeyType = UIReturnKeyNext;
    _senha.enablesReturnKeyAutomatically = YES;
    _senha.delegate = self;
    _senha.tag = 0;
    _cpf.enablesReturnKeyAutomatically = YES;
    //_cpf.keyboardType = UIKeyboardTypePhonePad;
    _cpf.returnKeyType = UIReturnKeyNext;
    _cpf.delegate = self;
    _cpf.tag = 2;
    _telefone.keyboardType = UIKeyboardTypePhonePad;
    _telefone.returnKeyType = UIReturnKeyNext;
    _telefone.delegate = self;
    _telefone.tag = 3;
    _nome.enablesReturnKeyAutomatically = YES;
    _nome.keyboardType = UIKeyboardTypeNamePhonePad;
    _nome.returnKeyType = UIReturnKeyNext;
    _nome.delegate = self;
    _nome.tag = 1;
    _nome.autocapitalizationType = YES;
    
    formulario = [[ASCFormulario alloc] init];
    _nome.text = @"";
    _cpf.text = @"";
    _telefone.text = @"";
    _senha.text = @"";
    
   cancelInfo = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enviarDados:(id)sender
{
    
    if(([formulario registerFilter:_nome WithMask:@"(\\w{2})"]) && ([formulario registerFilter:_cpf WithMask:@"(\\d{3}\\.\\d{3}\\.\\d{3}\\/\\d{2})"]) && ([_cpf.text length] < 15) && ([self checarTelefone]))
    {
        [self habilitarBotaoCancel:YES];
        [self mostrarPopUpMensagem:@"Enviar Dados?" Titulo:@"Confirmação"];
        [self habilitarBotaoCancel:NO];
    }
    else
    {
        if(![formulario registerFilter:_nome WithMask:@"(\\w{2})"])
        {
            [self mostrarPopUpMensagem:@"Deve conter ao menos duas letras" Titulo:@"Nome inválido"];
        }
        else if (!([formulario registerFilter:_senha WithMask:@"(?=(.*\\d){2})(?=(.*[A-Z]){2})"]) || ([_senha.text length] < 7))
        {
            [self mostrarPopUpMensagem:@"Deve ter ao menos 2 letras maiusculas, 2 numeros e no minimo 6 digitos" Titulo:@"Senha invalida"];
        }
        else if ([_cpf.text length] < 14)
        {
            [self mostrarPopUpMensagem:@"Formato: NNN.NNN.NNN/NN" Titulo:@"CPF inválido"];
        }
        else if (![self checarTelefone])
        {
           [self mostrarPopUpMensagem:@"Formato: [+NN](NN)NNNN-NNNN" Titulo:@"Telefone inválido"];
        }

    }
}


-(BOOL) checarDados: (UITextField*) textField
{
    if((textField == _nome) && ![formulario registerFilter:_nome WithMask:@"(\\w{2})"])
    {
        [self mostrarPopUpMensagem:@"Deve conter ao menos duas letras" Titulo:@"Nome inválido"];
        return NO;
    }
    else if ((textField == _senha) && (!([formulario registerFilter:_senha WithMask:@"(?=(.*\\d){2})(?=(.*[A-Z]){2})"]) || ([_senha.text length] < 7)))
    {
        [self mostrarPopUpMensagem:@"Deve ter ao menos 2 letras maiusculas, 2 numeros e no minimo 6 digitos" Titulo:@"Senha inválida"];
        return NO;
    }
    else if ((textField == _cpf) && ([_cpf.text length] < 14))
    {
        [self mostrarPopUpMensagem:@"Formato: NNN.NNN.NNN/NN" Titulo:@"CPF inválido"];
    }
    
    
    return YES;
}

-(BOOL) checarTelefone
{
    if(![_telefone.text isEqualToString: @""])
    {
        return [formulario registerFilter: _telefone WithMask: @"(\\[\\+\\d{2}\\]\\(\\d{2}\\)\\d{4}\\-\\d{4})"];
    }
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    if([self checarDados:textField])
    {
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
        return NO; // We do not want UITextField to insert line-breaks.
    }
    return YES;
}


-(void) salvarDados
{
    [formulario adicionarDadosNome:_nome.text Cpf:[_cpf.text intValue] Tel:[_telefone.text intValue] Senha:[_senha.text intValue]];
    [formulario salvarFormulario];
}

-(void) mostrarPopUpMensagem: (NSString *) mensagem Titulo: (NSString*) titulo
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titulo message:mensagem delegate:self cancelButtonTitle:cancelInfo otherButtonTitles:@"Ok",nil];
    [alert show];
}

-(void) habilitarBotaoCancel:(BOOL) cancel
{
    if(cancel)
    {
        cancelInfo = @"Cancelar";
    }
    else
    {
        cancelInfo = nil;
    }
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == _cpf)
    {
        NSString *cpf = textField.text;
        if([string isEqualToString:@""]) {
            textField.text = [self apagarCPF:textField.text inRange:range];
            
        } else {
            
            if(textField.text.length > 13)
                return NO;
            if(range.location == 3 || range.location == 7) {
                cpf = [NSString stringWithFormat:@"%@.%@",cpf,string];
                textField.text = [cpf substringToIndex:[cpf length] -1];
            } else {
                if(range.location == 11) {
                    cpf = [NSString stringWithFormat:@"%@/%@",cpf,string];
                    textField.text = [cpf substringToIndex:[cpf length] -1];
                }
            }
        }

    }
    else if (textField == _telefone)
    {
            if([string isEqualToString:@""])
                textField.text = [self apagarTelefone:textField.text inRange:range];
            if(textField.text.length >17)
                return NO;
            textField.text = [self adicionarTelefone:string em:textField.text inRange:range];
            return NO;
    }
    return YES;
}

-(NSString *) apagarTelefone:(NSString *)string inRange: (NSRange) range {
    if(range.location == 0 || range.location == 1)
        return @"";
    if(range.location == 5)
        return [string substringToIndex:string.length -3];
    if(range.location == 9 || range.location == 14)
        return [string substringToIndex:string.length -2];
    return [string substringToIndex: string.length -1];
}

-(NSString *) adicionarTelefone: (NSString *) stringParaAdd em: (NSString *) string inRange: (NSRange) range {
    if(range.location == 0)
        return [NSString stringWithFormat:@"[+%@",stringParaAdd];
    if(range.location == 4)
        return [NSString stringWithFormat:@"%@](%@",string,stringParaAdd];
    if(range.location == 8)
        return [NSString stringWithFormat:@"%@)%@",string,stringParaAdd];
    if(range.location == 13)
        return [NSString stringWithFormat:@"%@-%@",string,stringParaAdd];
    return [NSString stringWithFormat:@"%@%@",string,stringParaAdd];
    
}

-(NSString *) apagarCPF:(NSString *)string inRange: (NSRange) range {
    NSString *novaString;
    if(range.location == 3 || range.location == 7 || range.location == 11) {
        novaString = [NSString stringWithFormat:@"%@",[string substringToIndex: string.length - 1]];
    } else {
        novaString = [NSString stringWithFormat:@"%@",[string substringToIndex: string.length]];
    }
    return novaString;
}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self salvarDados];
       _nome.text = @"";
       _senha.text = @"";
       _cpf.text = @"";
       _telefone.text = @"";
    }
    
}

- (IBAction)sumirTeclado:(id)sender {
    [self.view endEditing:YES];
}
@end
