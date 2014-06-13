//
//  Mensagem.m
//  ApatiaPolitica
//
//  Created by Alex De Souza Campelo Lima on 6/13/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "Mensagem.h"

@implementation Mensagem
{
    NSMutableArray *messages;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        messages = [[NSMutableArray alloc] initWithObjects:@"oi",@"ola",@"ae", nil];
    }
    return self;
}
-(NSString*) randomizeMessages
{
    int fromNumber = 0;
    int toNumber = 2;
    int randomNumber = (arc4random()%(toNumber-fromNumber))+fromNumber;
    NSLog(@"%d random",randomNumber);
    return (NSString*) [messages objectAtIndex:randomNumber];
}

@end
