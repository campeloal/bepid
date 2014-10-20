//
//  ASCGameState.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCGameState.h"

@implementation ASCGameState

-(instancetype) init
{
    @throw [NSException exceptionWithName:@"SingletonException" reason:@"Cannot instantiate singleton" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate
{
    self = [super init];
    
    if (self) {
        _score = 0;
        _highScore = 0;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id highScore = [defaults objectForKey:@"highScore"];
        if (highScore) {
            _highScore = [highScore intValue];
        }
    }
    return self;
}

+(ASCGameState*) sharedState
{
    static dispatch_once_t token;
    static ASCGameState *gameState;
    dispatch_once(&token, ^{
        gameState = [[ASCGameState alloc] initPrivate];
    });
    return  gameState;
}

-(void) addScore:(NSUInteger)score
{
    _score += score;
}

-(void) resetScore
{
    _score = 0;
}

-(void) saveState
{
    _highScore = MAX(_score, _highScore);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithUnsignedInteger:_highScore] forKey:@"highScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
