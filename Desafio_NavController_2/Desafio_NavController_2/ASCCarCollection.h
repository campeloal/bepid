//
//  ASCCarCollection.h
//  Desafio_NavController_2
//
//  Created by Alex on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCCar.h"

@interface ASCCarCollection : NSObject

@property (nonatomic) NSMutableArray *cars;

+ (id)sharedCarCollection;
-(NSString*) obterNomeIndex: (int) i;
-(NSString*) obterPlacaIndex: (int) i;
-(NSString*) obterStatusIndex: (int) i;
-(NSString*) obterModeloIndex: (int) i;
-(NSString*) obterValorIndex: (int) i;
-(NSString*) obterDataFimIndex: (int) i;
-(NSString*) obterDataInicioIndex: (int) i;
-(int) obterDias: (int) i;
-(int) obterNumberCars;
-(void) setDataFim: (NSString*) dataFim Index: (int) i;
-(void) setDataInicio: (NSString*) dataInicio Index: (int) i;
-(void) setStatus: (NSString*) status Index: (int) i;

@end
