//
//  ASCFormulario.h
//  DesafioTextField
//
//  Created by Teste on 25/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCFormulario : NSObject

-(void) salvarFormulario;
-(void) adicionarDadosNome: (NSString*) nome Cpf: (int) cpf Tel: (int) tel Senha: (int) senha;

@end
