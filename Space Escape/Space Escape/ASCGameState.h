//
//  ASCGameState.h
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCGameState : NSObject

@property (nonatomic) NSUInteger score;
@property (nonatomic) NSUInteger highScore;

+(ASCGameState *) sharedState;

-(void) addScore:(NSUInteger) score;
-(void) resetScore;
-(void) saveState;


@end
