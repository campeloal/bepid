//
//  ASCPlayer.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCPlayer.h"
#define SPEED_RUN 20
#define SPEED_COLLISON 1000
#define BALL_DIRECTION_IMPULSE 800

@implementation ASCPlayer

- (instancetype)initInPosition: (CGPoint) position
{
    self = [super init];
    if(self)
    {
        _player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        
        _player.position = CGPointMake(position.x - _player.size.height/2, position.y);
        
        _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        _player.physicsBody.affectedByGravity = YES;
        _player.physicsBody.dynamic = YES;
        _player.physicsBody.allowsRotation = NO;
        _player.physicsBody.friction = 0.0;
        _player.physicsBody.categoryBitMask = playerCategory;
        _player.physicsBody.contactTestBitMask = playerCategory | netCategory | ballCategory;
        _player.name = @"player";
        
        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        _ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ball.frame.size.width/2];
        _ball.physicsBody.dynamic = YES;
        _ball.physicsBody.categoryBitMask = ballCategory;
        _ball.physicsBody.contactTestBitMask = ballCategory | playerCategory | netCategory;
        _ball.position = CGPointMake(10, self.frame.size.height/3);
        _ball.xScale = 0.1;
        _ball.yScale = 0.1;
        _ball.physicsBody.friction = 0.0;
        //_ball.physicsBody.linearDamping = 0.0f;
        _ball.physicsBody.allowsRotation = NO;
        _ball.name = @"ball";
        _ball.physicsBody.restitution = 1.0f;
        _ball.physicsBody.affectedByGravity = YES;
        
        _net = [SKSpriteNode spriteNodeWithImageNamed:@"net"];
        _net.position = CGPointMake([[UIScreen mainScreen] bounds].size.width - _net.size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        _net.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_net.frame.size];
        _net.physicsBody.affectedByGravity = NO;
        _net.physicsBody.allowsRotation = NO;
        _net.physicsBody.dynamic = NO;
        _net.physicsBody.categoryBitMask = netCategory;
        _net.physicsBody.contactTestBitMask = netCategory | playerCategory | ballCategory;
        _net.physicsBody.friction = 0.0;
        _net.name = @"net";
    
        
    }

    return self;
}

-(void)update:(CFTimeInterval)currentTime {
 
    _player.physicsBody.velocity = CGVectorMake(_player.physicsBody.velocity.dx,_player.physicsBody.velocity.dy + _accY*SPEED_RUN);
    
//    SKNode* ball = [self childNodeWithName: @"ball"];
//    static int maxSpeed = 1000;
//    float speed = sqrt(ball.physicsBody.velocity.dx*ball.physicsBody.velocity.dx + ball.physicsBody.velocity.dy * ball.physicsBody.velocity.dy);
//    if (speed > maxSpeed) {
//        ball.physicsBody.linearDamping = 0.4f;
//    } else {
//        ball.physicsBody.linearDamping = 0.0f;
//    }
}

-(void) ballCollision
{
    CGVector reflecDir = CGVectorMake(_ball.position.x - _player.position.x, _ball.position.y - _ball.position.y);
    
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

-(void) jump
{
     _player.physicsBody.velocity = CGVectorMake(-1000,_player.physicsBody.velocity.dy);
    
}


-(void) netCollision
{
    if(_net.position.y < _player.position.y)
    {
        _player.physicsBody.velocity = CGVectorMake(_player.physicsBody.velocity.dx,_player.physicsBody.velocity.dy + fabs(_accY)*SPEED_COLLISON);
    }
    else
    {
        _player.physicsBody.velocity = CGVectorMake(_player.physicsBody.velocity.dx,_player.physicsBody.velocity.dy - fabs(_accY)*SPEED_COLLISON);
    }
}



@end
