//
//  ASCEnemy.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCEnemy.h"
#import "ASCBullet.h"
#import "PhysicsCategories.h"

@implementation ASCEnemy

-(instancetype) initWithPosition:(CGPoint)position
{
    self = [super initWithImageNamed:@"inimigo1"];
    if (self) {
        self.position = position;
        
        [self startMoving];
        [self startShooting];
        [self selfDestructiveDelay:5];
        [self configurePhysicsBody];
    }
    
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    [self removeBullets];
}

-(void) startMoving
{
    SKAction *move = [SKAction moveByX:0 y:-60 duration:1];
    [self runAction:[SKAction repeatActionForever:move]];
    
}

-(void) startShooting
{
    SKAction *shoot = [SKAction runBlock:^{
        [self shootAtAngle: 270 andSpeed: 150];
    }];
    SKAction *delay = [SKAction waitForDuration:1.0];
    SKAction *sequence = [SKAction sequence:@[shoot,delay]];
    
    [self runAction:[SKAction repeatActionForever:sequence]];
}

-(void) shootAtAngle: (float) angleDegrees andSpeed: (float) speed{
    ASCBullet *bullet = [[ASCBullet alloc] initWithPosition:self.position bulletSpeed:speed angle:angleDegrees andImageNamed:@"tiro_inimigo"];
    [self.parent addChild:bullet];
    bullet.physicsBody.categoryBitMask = CollyderTypeBulletEnemy;
}

-(void) selfDestructiveDelay: (float) delay
{
    
    SKAction *delayAction= [SKAction waitForDuration:delay];
    SKAction *remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[delayAction,remove]]];
    
}

-(void) removeBullets
{
    NSArray *allBullets = [self.parent children];
    
    for(SKNode *eachBullet in allBullets) {
        if(([eachBullet position].y) < self.scene.frame.origin.y ) {
            //NSLog(@"REMOVING: %@ WITH POSITION: %@", [eachBullet name], NSStringFromCGPoint([eachBullet position]));
            [eachBullet removeFromParent];
        }
    }
}

-(void) configurePhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.categoryBitMask = CollyderTypeEnemy;
    self.physicsBody.contactTestBitMask = CollyderTypePlayer | CollyderTypeBulletPlayer;
    self.physicsBody.collisionBitMask = 0;
}

-(void) destroyEnemy
{
    [self removeFromParent];
}


@end
