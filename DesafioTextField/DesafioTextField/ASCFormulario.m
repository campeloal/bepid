//
//  ASCFormulario.m
//  DesafioTextField
//
//  Created by Teste on 25/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ASCFormulario.h"

@interface ASCFormulario()
{
    NSMutableArray *formulario;
}

@end

@implementation ASCFormulario


- (id)init
{
    self = [super init];
    if (self) {
        formulario = [[NSMutableArray alloc] init];
    }
    return self;
}
-(NSString*) adquirirCaminho
{
    NSArray* caminho = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[caminho objectAtIndex:0] stringByAppendingPathComponent:@"formulario.plist"];
}

-(void) adicionarDadosNome:(NSString *)nome Cpf:(int)cpf Tel:(int)tel Senha:(int)senha
{
    [formulario addObject:nome];
    [formulario addObject:[NSNumber numberWithInt:cpf]];
    [formulario addObject:[NSNumber numberWithInt:tel]];
    [formulario addObject:[NSNumber numberWithInt:senha]];
    _dataAtual = [NSDate date];
    [formulario addObject: _dataAtual];
}

-(BOOL) registerFilter:(UITextField*) field WithMask: (NSString *) mask
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:mask
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSString *registroText = field.text;
    NSArray *matches = [regex matchesInString:registroText
                                      options:0
                                        range:NSMakeRange(0, [registroText length])];
    if([matches count] == 1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

-(void) salvarFormulario
{
    [formulario writeToFile: [self adquirirCaminho] atomically:YES];
}

@end
