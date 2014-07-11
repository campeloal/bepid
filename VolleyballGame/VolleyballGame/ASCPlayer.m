//
//  ASCPlayer.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCPlayer.h"
#define SPEED_RUN 40
#define JUMP_VELOCITY -600

@implementation ASCPlayer

- (instancetype)initInPosition: (CGPoint) position
{
    self = [super init];
    if(self)
    {
        _player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        
        _player.position = CGPointMake(position.x - _player.size.height/2, position.y);
        
        _player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_player.frame.size.height/2*0.7];
        _player.physicsBody.affectedByGravity = YES;
        _player.physicsBody.dynamic = YES;
        _player.physicsBody.allowsRotation = NO;
        _player.physicsBody.friction = 0.0;
        _player.physicsBody.categoryBitMask = playerCat;
        _player.physicsBody.contactTestBitMask = playerCat | netCat | ballCat | floorCat | leftWallCat | rightWallCat | roundNetCat;
        _player.name = @"player";
        _player.xScale = 1.3;
        _player.yScale = 1.3;
    
        
    }

    return self;
}

-(void)update:(CFTimeInterval)currentTime {
 
    _player.physicsBody.velocity = CGVectorMake(_player.physicsBody.velocity.dx,_player.physicsBody.velocity.dy + _accY*SPEED_RUN);
    
}

-(void) jump
{
     _player.physicsBody.velocity = CGVectorMake(JUMP_VELOCITY,_player.physicsBody.velocity.dy);
    
}



@end
