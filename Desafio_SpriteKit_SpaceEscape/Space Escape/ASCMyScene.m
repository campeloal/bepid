//
//  ASCMyScene.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/8/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCMyScene.h"
#import "PhysicsCategories.h"

@interface ASCMyScene()

@property SKSpriteNode *retryButton;

@end

@implementation ASCMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _enemies = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void) didMoveToView:(SKView *)view
{
    self.world = [SKNode node];
    self.hudLayer = [SKNode node];
    
    [self createBackground];
    [self createHud];
    [self createPlayer];
    [self enemyGenerator];
    
    [self addChild:self.world];
    
    [self setupPhysics];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (CGRectContainsPoint(_retryButton.frame, location))
    {
        self.highScoreLabel.hidden = YES;
        self.scoreLabel.hidden = NO;
        [self.retryButton removeFromParent];
        [ASCGameState sharedState].score = 0;
        self.world.paused = NO;
        [self createPlayer];
        
    }
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_player touchesMoved:touches withEvent:event];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [_player update:currentTime];
    for (ASCEnemy *enemy in _enemies) {
        [enemy update:currentTime];
    }
    [self.scoreLabel update];
}

-(void) didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask;
    
    if (collision == (CollyderTypePlayer | CollyderTypeEnemy)) {
        ASCPlayer *player;
        ASCEnemy *enemy;
        
        if ([contact.bodyA.node isKindOfClass:[ASCPlayer class]]) {
            player = (ASCPlayer*) contact.bodyA.node;
            enemy = (ASCEnemy*) contact.bodyB.node;
        }
        else {
            player = (ASCPlayer*) contact.bodyB.node;
            enemy = (ASCEnemy*) contact.bodyA.node;
        }
        
        [player destroyPlayer];
        [enemy destroyEnemy];
        [self gameOver];
    }
    else if (collision == (CollyderTypePlayer | CollyderTypeBulletEnemy))
    {
        ASCPlayer *player;
        ASCBullet *bullet;
        
        if ([contact.bodyA.node isKindOfClass:[ASCPlayer class]]) {
            player = (ASCPlayer*) contact.bodyA.node;
            bullet = (ASCBullet*) contact.bodyB.node;
        }
        else
        {
            player = (ASCPlayer*) contact.bodyB.node;
            bullet = (ASCBullet*) contact.bodyA.node;
        }
        
        [player destroyPlayer];
        [bullet destroyBullet];
        [self gameOver];
    }
    else if(collision == (CollyderTypeEnemy | CollyderTypeBulletPlayer))
    {
        ASCEnemy *enemy;
        ASCBullet *bullet;
        
        if ([contact.bodyA.node isKindOfClass:[ASCEnemy class]]) {
            enemy = (ASCEnemy*) contact.bodyA.node;
            bullet = (ASCBullet*) contact.bodyB.node;
        }
        else
        {
            enemy = (ASCEnemy*) contact.bodyB.node;
            bullet = (ASCBullet*) contact.bodyA.node;
        }
        
        [[ASCGameState sharedState] addScore:1];
        [enemy destroyEnemy];
        [bullet destroyBullet];
    }
}


-(void) createPlayer
{
    _player = [[ASCPlayer alloc] initWithPosition:CGPointMake(self.size.width/2, self.size.height/4)];
    [self addChild:self.player];
}

-(void) enemyGenerator
{
    SKAction *enemyGenerator = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:1 withRange:0], [SKAction performSelector:@selector(callEnemies) onTarget:self]]]];
    
    [self runAction:enemyGenerator];
}

-(void) callEnemies
{
    ASCEnemy *enemy = [[ASCEnemy alloc] initWithPosition:[self randomizePosition]];
    [_enemies addObject:enemy];
    [self.world addChild:enemy];
}

-(CGPoint) randomizePosition
{
    float screenSizeWidth = self.size.width;
    float screenSizeHeight = self.scene.size.height*1.1;
    
    int randomWidthPosition = 1 + arc4random() % ((int) screenSizeWidth -1 );
    int randomHeightPosition = (int) self.size.height + arc4random() % ((int) screenSizeHeight - (int) self.size.height);
    
    CGPoint position = CGPointMake(randomWidthPosition, randomHeightPosition);

    return position;
}

-(void) setupPhysics
{
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}

-(void) createBackground
{
    self.backgroundLayer = [[ASCBackgroundLayer alloc] initWithSize:self.size];
    [self.world addChild:self.backgroundLayer];
}

-(void) createHud
{
    self.scoreLabel = [[ASCLabel alloc] initWithFontNamed:@"Futura-CondensedExtraBold"];
    self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-50);
    [self.hudLayer addChild:self.scoreLabel];
    [self addChild:self.hudLayer];
}

-(void) gameOver
{
    int score = [ASCGameState sharedState].score;
    
    if ([ASCGameState sharedState].highScore < score) {
        [ASCGameState sharedState].highScore = score;
    }
    
    
    self.scoreLabel.hidden = YES;
    self.highScoreLabel = [[ASCLabel alloc] initWithFontNamed:@"Futura=CondensedExtraBold"];
    self.highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-50);
    self.highScoreLabel.text = [NSString stringWithFormat:@"HighScore: %lu",(unsigned long) [ASCGameState sharedState].highScore];
    self.highScoreLabel.zPosition = 1.0;
    self.world.paused = YES;
    _retryButton = [SKSpriteNode spriteNodeWithImageNamed:@"retry.png"];
    _retryButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-90);
    _retryButton.zPosition = 2.0;
    [_retryButton setScale:0.2];
    [self.hudLayer addChild:self.highScoreLabel];
    [self.hudLayer addChild:self.retryButton];
}



@end
