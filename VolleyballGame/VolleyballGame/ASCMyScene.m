//
//  ASCMyScene.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/1/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCMyScene.h"
#import "ASCPlayer.h"

@implementation ASCMyScene
{
    ASCPlayer *player;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        player = [[ASCPlayer alloc] init];
        
        _currentLocation = [player player].position;
        
        self.physicsWorld.gravity = CGVectorMake(10.0f,0.0f);
        self.physicsWorld.contactDelegate = self;
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        [self addChild:[player player]];
        [self addChild:[player ball]];
        [self addChild: [player net]];

    }
    return self;
}

-(void) didBeginContact:(SKPhysicsContact *)contact
{
    if((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == ballCategory))
    {
        [player ballCollision];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    [player setCurrentLocation:_currentLocation];
    [player update:currentTime];
}

-(void) jump
{
    [player jump];
}

@end
