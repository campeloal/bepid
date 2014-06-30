//
//  ASCNome.m
//  DesafioNavigationController
//
//  Created by Alex De Souza Campelo Lima on 7/7/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCNome.h"

@implementation ASCNome

+(id) sharedNome
{
    static ASCNome *sharedNome =nil;
    
    if(!sharedNome)
    {
        sharedNome = [[self alloc] initPrivate];
    }
    
    return sharedNome;
}

-(id) initPrivate
{
    self = [super init];
    
    if(self)
    {
        _nome = [[NSString alloc] init];
        _nome = @"nome default";
        _idade = 18;
        _altura = 1.7;
        _peso = 60;
        
    }
    
    return self;
}

-(id) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [ASCNome sharedNome]" userInfo:nil];
}

-(id) obterSharedNome
{
    return self.nome;
}

-(int) obterSharedIdade
{
    return self.idade;
}

-(float) obterSharedAltura
{
    return  self.altura;
}

-(float) obterSharedPeso
{
    return self.peso;
}

-(void) setarSharedNome: (NSString*) nome
{
    _nome = nome;
}

-(void) setarSharedIdade:(int)idade
{
    _idade = idade;
}

-(void) setarSharedAltura: (float) altura
{
    _altura = altura;
}

-(void) setarSharedPeso:(float)peso
{
    _peso = peso;
}


@end
