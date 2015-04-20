//
//  ASCPlayer.h
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/8/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ASCBullet.h"

@interface ASCPlayer : SKSpriteNode

-(instancetype) initWithPosition: (CGPoint) position;
-(void) destroyPlayer;
-(void) removeBullets;
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)update:(CFTimeInterval)currentTime;

@end
