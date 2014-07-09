//
//  ASCCarCollection.m
//  Desafio_NavController_2
//
//  Created by Alex on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCCarCollection.h"

@implementation ASCCarCollection

+ (id)sharedCarCollection
{
    static ASCCarCollection *sharedCar = nil;
    
    if (!sharedCar) {
        sharedCar = [[self alloc] initPrivate];
       
    }
    return sharedCar;
}

-(id) initPrivate
{
    _cars = [[NSMutableArray alloc] init];
    ASCCar *car1 = [[ASCCar alloc] init];
    car1.name = @"Ford k";
    car1.placa = @"jgp1234";
    car1.status = @"Alugado";
    car1.modelo = @"2013";
    car1.valor = @"R$ 100,00";
    car1.dataInicio = @"";
    car1.dataFim = @"05/07/2013";
    car1.dias = 30;
    [_cars addObject:car1];
    
    ASCCar *car2 = [[ASCCar alloc] init];
    car2.name = @"Ford Fusion";
    car2.placa = @"ovr4563";
    car2.status = @"Disponível";
    car2.modelo = @"2012";
    car2.valor = @"R$ 100,00";
    car2.dataInicio = @"";
    car2.dias = 29;
    car2.dataFim = @"";
    [_cars addObject:car2];
    
    ASCCar *car3 = [[ASCCar alloc] init];
    car3.name = @"Gol";
    car3.placa = @"jip9078";
    car3.status = @"Disponível";
    car3.modelo = @"2014";
    car3.valor = @"R$ 150,00";
    car3.dataInicio = @"";
    car3.dias = 31;
    car3.dataFim = @"";
    [_cars addObject:car3];
    
    return self;
}

-(NSString*) obterNomeIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.name;
}

-(NSString*) obterPlacaIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.placa;
}

-(NSString*) obterStatusIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.status;
}

-(NSString*) obterModeloIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.modelo;
}

-(NSString*) obterValorIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.valor;
}

-(NSString*) obterDataInicioIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.dataInicio;
}

-(NSString*) obterDataFimIndex: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.dataFim;
}

-(void) setStatus: (NSString*) status Index: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    currentCar.status = status;
}

-(void) setDataInicio: (NSString*) dataInicio Index: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    currentCar.dataInicio = dataInicio;
}

-(void) setDataFim: (NSString*) dataFim Index: (int) i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    currentCar.dataFim = dataFim;
}

-(int) obterNumberCars
{
    return [_cars count];
}

-(int) obterDias:(int)i
{
    ASCCar *currentCar = [_cars objectAtIndex:i];
    return currentCar.dias;
}

@end
