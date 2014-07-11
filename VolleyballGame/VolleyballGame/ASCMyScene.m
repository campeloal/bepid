//
//  ASCMyScene.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/1/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCMyScene.h"
#import "ASCPlayer.h"
#import "ASCCourt.h"

@implementation ASCMyScene
{
    ASCPlayer *player;
    ASCCourt *court;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        player = [[ASCPlayer alloc] initInPosition:CGPointMake(self.frame.size.width, 50)];
        
        court = [[ASCCourt alloc] init];
        [court createBoundariesInsideScreen:self.frame];
        
        _currentLocation = [player player].position;
        
        self.physicsWorld.gravity = CGVectorMake(10.0f,0.0f);
        self.physicsWorld.contactDelegate = self;
        
        //CGRect screen = self.frame;
        
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:screen];
        
        [self addChild:[player player]];
        [self addChild:[court ball]];
        [self addChild: [court net]];
        [self addChild: [court roundNet]];
        [self addChild:[court floor]];
        [self addChild:[court leftWall]];
        [self addChild:[court rightWall]];

    }
    return self;
}

-(void) didBeginContact:(SKPhysicsContact *)contact
{
    
    if(((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == ballCategory)) || ((contact.bodyA.categoryBitMask == ballCategory) && (contact.bodyB.categoryBitMask == playerCategory)))
    {
        [court ballCollision:[player player]];
    }
    else if (((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == netCategory)) || ((contact.bodyA.categoryBitMask == netCategory) && (contact.bodyB.categoryBitMask == playerCategory)))
    {
        [court netCollision:[player player] Acceleration:self.accY Round:NO];
    }
    else if ((contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == roundNetCategory))
    {
        [court netCollision:[player player] Acceleration:self.accY Round:YES];
    }
    
}


-(void)update:(CFTimeInterval)currentTime {
    [player setCurrentLocation:_currentLocation];
    player.accY = self.accY;
    [player update:currentTime];
}

-(void) jump
{
    [player jump];
}

@end
