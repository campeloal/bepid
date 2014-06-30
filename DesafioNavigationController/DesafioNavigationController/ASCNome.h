//
//  ASCNome.h
//  DesafioNavigationController
//
//  Created by Alex De Souza Campelo Lima on 7/7/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCNome : NSObject

@property (nonatomic) NSString *nome;
@property (nonatomic) int idade;
@property (nonatomic) float altura;
@property (nonatomic) float peso;

+(id) sharedNome;
-(id) obterSharedNome;
-(int) obterSharedIdade;
-(float) obterSharedAltura;
-(float) obterSharedPeso;

-(void) setarSharedNome: (NSString*) nome;
-(void) setarSharedIdade:(int)idade;
-(void) setarSharedAltura:(float)altura;
-(void) setarSharedPeso:(float)peso;


@end
