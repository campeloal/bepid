//
//  ASCPlayer.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCPlayer.h"

@implementation ASCPlayer

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        
        _player.position = CGPointMake([[UIScreen mainScreen] bounds].size.width - _player.size.height/2, 50);
        
        _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        _player.physicsBody.affectedByGravity = NO;
        _player.physicsBody.dynamic = YES;
        _player.physicsBody.allowsRotation = NO;
        _player.physicsBody.friction = 0.0;
        _player.physicsBody.categoryBitMask = playerCategory;
        _player.physicsBody.contactTestBitMask = playerCategory | netCategory | ballCategory;
        
        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        _ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ball.frame.size.width/2];
        _ball.physicsBody.dynamic = YES;
        _ball.physicsBody.categoryBitMask = ballCategory;
        _ball.physicsBody.contactTestBitMask = ballCategory | playerCategory | netCategory;
        _ball.position = CGPointMake(100, 50);
        _ball.xScale = 0.1;
        _ball.yScale = 0.1;
        _ball.physicsBody.friction = 0.0;
        _ball.physicsBody.linearDamping = 0.0f;
        _ball.physicsBody.allowsRotation = NO;
        //_ball.physicsBody.restitution = 1.0f;
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
    
        
    }

    return self;
}

-(void)update:(CFTimeInterval)currentTime {
 
    //_player.position = _currentLocation;
    _player.physicsBody.velocity = CGVectorMake(0,_currentLocation.y - _player.position.y);
    //[self confineToBounds:_player];
    
}

-(void) ballCollision
{
    _ball.physicsBody.velocity = CGVectorMake(-100,0);
    [_ball.physicsBody applyImpulse:CGVectorMake(-1000, 0)];
}

-(void) jump
{
    
    float originalX = _player.position.x;
    SKAction *jump = [SKAction moveToX:-15 duration:.3];
    SKAction *down = [SKAction moveToX:originalX duration:.3];
    SKAction *action = [SKAction sequence:@[jump, down]];
    
    [_player runAction:action];
    
}

- (void)confineToBounds: (SKSpriteNode *) object {
    
    CGPoint correctedPos = object.position;
    BOOL changePos = NO;
    float xLeft = 0;
    float xRight = [[UIScreen mainScreen] bounds].size.height;
    float yUp = 0;
    float yDown = [[UIScreen mainScreen] bounds].size.width;
    
    if(correctedPos.x + object.frame.size.height <= yUp) {correctedPos.x = yUp; changePos = YES;}
    if(correctedPos.x >= yDown) {correctedPos.x = yDown; changePos = YES;}
    if(correctedPos.y <= xLeft) {correctedPos.y = xLeft + object.frame.size.width/2; changePos = YES;}
    if(correctedPos.y >= xRight) {correctedPos.y = xRight - object.frame.size.width/2; changePos = YES;}
    
    if(changePos)
    {
        object.position = correctedPos;
    }
    
}



@end
