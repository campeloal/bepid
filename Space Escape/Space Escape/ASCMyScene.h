//
//  ASCMyScene.h
//  Space Escape
//

//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASCPlayer.h"
#import "ASCEnemy.h"
#import "ASCBackgroundLayer.h"
#import "ASCLabel.h"
#import "ASCGameState.h"

@interface ASCMyScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic) ASCPlayer *player;
@property (nonatomic) ASCBackgroundLayer *backgroundLayer;
@property (nonatomic) NSMutableArray *enemies;
@property (nonatomic) SKNode *world;
@property (nonatomic) SKNode *hudLayer;
@property (nonatomic) ASCLabel *scoreLabel;
@property (nonatomic) ASCLabel *highScoreLabel;

@end
