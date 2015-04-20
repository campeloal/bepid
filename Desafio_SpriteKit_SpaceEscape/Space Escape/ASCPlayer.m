//
//  ASCPlayer.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/8/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCPlayer.h"
#import "PhysicsCategories.h"

@implementation ASCPlayer

- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super initWithImageNamed:@"player"];
    if (self) {
        self.position = position;
        
        [self startShooting];
        [self configurePhysicsBody];
    }
    return self;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint lastLocation = [touch previousLocationInNode:self.parent];
    CGPoint touchLocation = [touch locationInNode:self.parent];

    CGPoint difference = CGPointMake(touchLocation.x-lastLocation.x, touchLocation.y - lastLocation.y);
    CGPoint desiredPosition = CGPointMake(self.position.x + difference.x, self.position.y + difference.y);
  
    float maxX = [UIScreen mainScreen].bounds.size.width - self.frame.size.width/2;
    float maxY = [UIScreen mainScreen].bounds.size.height - self.frame.size.width/2;
    float minX = self.frame.size.width/2;
    float minY = self.frame.size.height/2;
    
    float posX = desiredPosition.x;
    float posY = desiredPosition.y;

    if(desiredPosition.x > maxX)
    {
        posX = maxX;
    }else if(desiredPosition.x < minX)
        
    {
        posX = minX;
    }
    
    if(desiredPosition.y > maxY)
    {
        posY = maxY;
    }
    else if(desiredPosition.y < minY)
        
    {
        posY = minY;
        
    }
    
    self.position = CGPointMake(posX, posY);
}

-(void)update:(CFTimeInterval)currentTime {
    [self removeBullets];
}

-(void) startShooting
{
    SKAction *shoot = [SKAction runBlock:^{
        [self shootAtAngle: 90 andSpeed: 150];
    }];
    SKAction *delay = [SKAction waitForDuration:1.0];
    SKAction *sequence = [SKAction sequence:@[shoot,delay]];
    
    [self runAction:[SKAction repeatActionForever:sequence]];
}

-(void) shootAtAngle: (float) angleDegrees andSpeed: (float) speed{
    ASCBullet *bullet = [[ASCBullet alloc] initWithPosition:self.position bulletSpeed:speed angle:angleDegrees andImageNamed:@"tiro_player"];
    [self.parent addChild:bullet];
    bullet.physicsBody.categoryBitMask = CollyderTypeBulletPlayer;
}

-(void) removeBullets
{
    NSArray *allBullets = [self.parent children];
    
    for(SKNode *eachBullet in allBullets) {
        if(([eachBullet position].y) > (self.scene.frame.origin.y + self.scene.frame.size.height)) {
            //NSLog(@"REMOVING: %@ WITH POSITION: %@", [eachBullet name], NSStringFromCGPoint([eachBullet position]));
            [eachBullet removeFromParent];
        }
    }
}

-(void) configurePhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.categoryBitMask = CollyderTypePlayer;
    self.physicsBody.contactTestBitMask = CollyderTypeEnemy | CollyderTypeBulletEnemy;
    self.physicsBody.collisionBitMask = 0;
}

-(void) destroyPlayer
{
    [self removeFromParent];
}

@end
