//
//  ASCPlayer.h
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t ballCat     =  0x1 << 1;
static const uint32_t playerCat    =  0x1 << 0;
static const uint32_t netCat    =  0x1 << 2;
static const uint32_t floorCat = 0x1 << 3;
static const uint32_t leftWallCat = 0x1 << 4;
static const uint32_t rightWallCat = 0x1 << 5;
static const uint32_t roundNetCat = 0x1 << 6;

@interface ASCPlayer : SKScene

@property CGPoint currentLocation;
@property float accY;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) uint32_t playerCategory;
@property (nonatomic) uint32_t netCategory;
@property (nonatomic) uint32_t ballCategory;

- (instancetype)initInPosition: (CGPoint) position;
-(void)update:(CFTimeInterval)currentTime;
-(void) jump;

@end
