//
//  ASCItem.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/18/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCItem.h"


@implementation ASCItem

@dynamic dateCreated;
@dynamic itemName;
@dynamic serialNumber;
@dynamic value;
@dynamic orderingValue;
@dynamic owner;

-(void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];

}

- (void)randomData
{

    self.itemName = [self createDevice];
    self.owner = [self createOwner];
    self.serialNumber = [self createSerialNumber];
    self.value = (int) arc4random_uniform(15001);
    //self.orderingValue = (int) arc4random_uniform(100);
    NSLog(@"ordering value %f", self.orderingValue);
}

-(NSString*) createOwner
{
    NSArray *names = [[NSArray alloc] initWithObjects:@"Antônio",@"Bruno",@"Cézar",@"Daniel",@"Elton",@"Fábio",@"Guilherme", nil];
    NSString * name = [names objectAtIndex:arc4random_uniform((int) [names count])];

    return name;
}

-(NSString*) createDevice
{
    NSArray *devices =[[NSArray alloc] initWithObjects:@"iPhone",@"iPad",@"iMac",@"MacBook",@"MacMini",@"Ipod",nil];
    
    NSString *device = [devices objectAtIndex:arc4random_uniform((int) [devices count])];
    
    return device;
}

-(NSString*) createSerialNumber
{
    
    return [NSString stringWithFormat:@"%c%c%c%c%c", [self getRandomCharacter:NO], [self getRandomCharacter:YES],[self getRandomCharacter:NO],[self getRandomCharacter:YES],[self getRandomCharacter:NO]];
}

-(char) getRandomCharacter: (BOOL) isLetter
{
    char finalChar;
    if (isLetter) {
        NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        finalChar = [letters characterAtIndex:arc4random()%[letters length]];
        return finalChar;
    }
    else
    {
        NSString *numbers = @"0123456789";
        finalChar = [numbers characterAtIndex:arc4random()%[numbers length]];
        return finalChar;
    }
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ do %@", self.itemName, self.owner ];
}

@end
