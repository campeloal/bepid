//
//  ASCCourt.h
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/11/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t playerCategory     =  0x1 << 0;
static const uint32_t ballCategory     =  0x1 << 1;
static const uint32_t netCategory     =  0x1 << 2;
static const uint32_t floorCategory = 0x1 << 3;
static const uint32_t leftWallCategory = 0x1 << 4;
static const uint32_t righttWallCategory = 0x1 << 5;
static const uint32_t roundNetCategory = 0x1 << 6;


@interface ASCCourt : NSObject

@property (nonatomic) SKSpriteNode *ball;
@property (nonatomic) SKSpriteNode *net;
@property (nonatomic) SKNode *floor;
@property (nonatomic) SKNode *leftWall;
@property (nonatomic) SKNode *rightWall;
@property (nonatomic) SKSpriteNode *roundNet;

-(void) createBoundariesInsideScreen:(CGRect) screen;
-(void) ballCollision: (SKSpriteNode*) objectToCollide;
-(void) netCollision: (SKSpriteNode*) objectToCollide Acceleration: (float) accY Round: (BOOL) isRound;

@end
