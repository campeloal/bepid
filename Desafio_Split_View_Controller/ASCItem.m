//
//  ASCItem.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCItem.h"

@interface ASCItem()

@end

@implementation ASCItem

+ (instancetype)randomItem
{
    static ASCItem *item = nil;
    @synchronized(self) {
        if (item == nil)
        {
            item = [[self alloc] initWithItemName: [self createName] value: (int) arc4random_uniform(15001) serialNumber: [self createSerialNumber]];

        }
    }
    return item;
}

+(NSString*) createName
{
    NSArray *names = [[NSArray alloc] initWithObjects:@"Antônio",@"Bruno",@"Cézar",@"Daniel",@"Elton",@"Fábio",@"Guilherme", nil];
    NSString * name = [names objectAtIndex:arc4random_uniform((int) [names count])];
    
    NSArray *devices =[[NSArray alloc] initWithObjects:@"iPhone",@"iPad",@"iMac",@"MacBook",@"MacMini",@"Ipod",nil];
    
    NSString *device = [devices objectAtIndex:arc4random_uniform((int) [devices count])];
    
    return [NSString stringWithFormat:@"%@%@%@",device,@" do ",name];
}

+(NSString*) createSerialNumber
{
    
    return [NSString stringWithFormat:@"%c%c%c%c%c", [self getRandomCharacter:NO], [self getRandomCharacter:YES],[self getRandomCharacter:NO],[self getRandomCharacter:YES],[self getRandomCharacter:NO]];
}

+(char) getRandomCharacter: (BOOL) isLetter
{
    char finalChar;
    if (isLetter) {
        NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        finalChar = [letters characterAtIndex:arc4random_uniform(26)];
        return finalChar;
    }
    else
    {
        NSString *numbers = @"0123456789";
        finalChar = [numbers characterAtIndex:arc4random_uniform(11)];
        return finalChar;
    }
}

-(instancetype) initWithItemName:(NSString *)name value:(int)value serialNumber:(NSString *)sNumber
{
    
    self = [super init];
    if (self) {
        self.itemName = name;
        self.serialNumber = sNumber;
        self.value = value;
        
        NSLog(@"item name: %@", self.itemName);
        NSLog(@"item serial: %@", self.serialNumber);
        NSLog(@"item value: %d", self.value);
    }
    return self;
}

-(NSString*) getItemName
{
    return self.itemName;
}

-(NSString*) getSerialNumber
{
    return self.serialNumber;
}

-(int) getValue
{
    return self.value;
}

-(instancetype) initWithItemName:(NSString *)name
{
    
    self = [super init];
    if (self) {
        self.itemName = name;
    }
    return self;
}



@end
