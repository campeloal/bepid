//
//  ASCBullet.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCBullet.h"

@implementation ASCBullet

-(instancetype) initWithPosition:(CGPoint)position bulletSpeed:(float)speed angle:(float)angleDegrees andImageNamed:(NSString *)imageName
{
    self = [super initWithImageNamed:imageName];
    
    if (self) {
        float radians = angleDegrees/180*M_PI;
        
        self.position = position;
        self.bulletSpeed = speed;
        self.zRotation = radians;
        self.name = @"Bullet";
        [self configurePhysicsBody];
        
        [self startMoving];
    }
    return self;
}

-(void) startMoving
{
    CGVector movement = CGVectorMake(cosf(self.zRotation)*self.bulletSpeed, sinf(self.zRotation)*self.bulletSpeed);
    SKAction *move = [SKAction moveBy:movement duration:1];
    [self runAction:[SKAction repeatActionForever:move]];
}

-(void) configurePhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.collisionBitMask = 0;
}

-(void) destroyBullet
{
    [self removeFromParent];
}

@end
