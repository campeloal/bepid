//
//  ASCCourt.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/11/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCCourt.h"
#define BALL_DIRECTION_IMPULSE 700
#define WALL_IMPULSE 500
#define ROUND_WALL_IMPULSE 0.5

@implementation ASCCourt

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        _ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ball.frame.size.width/2];
        _ball.physicsBody.dynamic = YES;
        _ball.physicsBody.categoryBitMask = ballCategory;
        _ball.physicsBody.contactTestBitMask = ballCategory | netCategory | playerCategory | floorCategory | leftWallCategory | righttWallCategory | roundNetCategory;
        _ball.position = CGPointMake(10, 200);
        _ball.xScale = 0.12;
        _ball.yScale = 0.12;
        _ball.physicsBody.friction = 0.0;
        _ball.physicsBody.allowsRotation = NO;
        _ball.name = @"ball";
        _ball.physicsBody.restitution = 1.0f;
        _ball.physicsBody.affectedByGravity = YES;
        
        _net = [SKSpriteNode spriteNodeWithImageNamed:@"net"];
        _net.xScale = 0.5;
        _net.position = CGPointMake([[UIScreen mainScreen] bounds].size.width - _net.size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        _net.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_net.frame.size];
        _net.physicsBody.affectedByGravity = NO;
        _net.physicsBody.allowsRotation = NO;
        _net.physicsBody.dynamic = NO;
        _net.physicsBody.categoryBitMask = netCategory;
        _net.physicsBody.contactTestBitMask = netCategory | playerCategory | ballCategory | floorCategory;
        _net.physicsBody.friction = 0.0;
        _net.name = @"net";
        
        _roundNet = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        _roundNet.xScale = 0.1;
        _roundNet.yScale = 0.1;
        float radius = _net.frame.size.height/2;
        _roundNet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: radius*1.1];
        _roundNet.position = CGPointMake(_net.position.x  - _net.frame.size.width + 70, _net.position.y);
        _roundNet.physicsBody.collisionBitMask = 0;
        _roundNet.physicsBody.affectedByGravity = NO;
        _roundNet.physicsBody.categoryBitMask = roundNetCategory;

    }
    return self;
}

-(void) createBoundariesInsideScreen:(CGRect) screen
{
    _floor = [SKNode node];
    _floor.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint: CGPointMake(screen.size.width, 0)  toPoint: CGPointMake(screen.size.width, screen.size.height)];
    _floor.physicsBody.categoryBitMask = floorCategory;
    
    _leftWall = [SKNode node];
    _leftWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0) toPoint: CGPointMake(screen.size.width, 0)];
    _leftWall.physicsBody.categoryBitMask = leftWallCategory;
    
    _rightWall = [SKNode node];
    _rightWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, screen.size.height) toPoint: CGPointMake(screen.size.width, screen.size.height)];
    _rightWall.physicsBody.categoryBitMask = righttWallCategory;
    
}

-(void) ballCollision: (SKSpriteNode*) objectToCollide
{
    CGVector reflecDir = CGVectorMake(_ball.position.x - objectToCollide.position.x, _ball.position.y - _ball.position.y);
    
    if(reflecDir.dx > 0)
    {
        reflecDir.dx = BALL_DIRECTION_IMPULSE;
    }
    else
    {
        reflecDir.dx = -BALL_DIRECTION_IMPULSE;
    }
    
    if(reflecDir.dy > 0)
    {
        reflecDir.dy = BALL_DIRECTION_IMPULSE;
    }
    else
    {
        reflecDir.dy = -BALL_DIRECTION_IMPULSE;
    }
    
    _ball.physicsBody.velocity = reflecDir;
    [_ball.physicsBody applyImpulse:reflecDir];
}

-(void) netCollision: (SKSpriteNode*) objectToCollide Acceleration: (float) accY Round: (BOOL) isRound
{
    if(!isRound)
    {
        [self wallCollsion:objectToCollide Acceleration:accY];
    }
    else
    {
        [self roundWallCollision:objectToCollide];
        
        
    }
}

-(void) wallCollsion: (SKSpriteNode*) objectToCollide Acceleration: (float) accY
{
    if(_net.position.y < objectToCollide.position.y)
    {
        objectToCollide.physicsBody.velocity = CGVectorMake(objectToCollide.physicsBody.velocity.dx,objectToCollide.physicsBody.velocity.dy + fabs(accY)*WALL_IMPULSE);
    }
    else
    {
        objectToCollide.physicsBody.velocity = CGVectorMake(objectToCollide.physicsBody.velocity.dx,objectToCollide.physicsBody.velocity.dy - fabs(accY)*WALL_IMPULSE);
    }
}

-(void) roundWallCollision: (SKSpriteNode*) objectToCollide
{
    if(objectToCollide.position.x  > _roundNet.position.x)
    {
        if(objectToCollide.position.y > _roundNet.position.y)
        {
            //+ + pulo baixo direita
            objectToCollide.physicsBody.velocity = CGVectorMake(ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dx),ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dy));
            [objectToCollide.physicsBody applyImpulse:objectToCollide.physicsBody.velocity];
        }
        else
        {
            //+ - pulo baixo esquerda
            objectToCollide.physicsBody.velocity = CGVectorMake(ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dx),-ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dy));
            [objectToCollide.physicsBody applyImpulse:objectToCollide.physicsBody.velocity];
        }
    }
    else
    {
        
        if(objectToCollide.position.y > _roundNet.position.y)
        {
            //- + pulo alto direita
            objectToCollide.physicsBody.velocity = CGVectorMake(-ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dx),ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dy));
            [objectToCollide.physicsBody applyImpulse:objectToCollide.physicsBody.velocity];
        }
        else
        {
            // - - pulo alto esquerda
            objectToCollide.physicsBody.velocity = CGVectorMake(-ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dx),-ROUND_WALL_IMPULSE*fabs(objectToCollide.physicsBody.velocity.dy));
            [objectToCollide.physicsBody applyImpulse:objectToCollide.physicsBody.velocity];
        }
    }
}


@end
