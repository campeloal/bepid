//
//  ASCPlayer.h
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t ballCategory     =  0x1 << 1;
static const uint32_t playerCategory     =  0x1 << 0;
static const uint32_t netCategory     =  0x1 << 2;

@interface ASCPlayer : SKScene

@property CGPoint currentLocation;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) SKSpriteNode *ball;
@property (nonatomic) SKSpriteNode *net;

-(void)update:(CFTimeInterval)currentTime;
-(void) ballCollision;
-(void) jump;

@end
