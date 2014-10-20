//
//  ASCBullet.h
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASCBullet : SKSpriteNode

-(instancetype) initWithPosition:(CGPoint)position bulletSpeed: (float)speed angle: (float) angleDegrees andImageNamed: (NSString*) imageName;
-(void) destroyBullet;

@property (nonatomic) float bulletSpeed;

@end
