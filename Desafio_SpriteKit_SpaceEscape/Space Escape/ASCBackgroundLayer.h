//
//  ASCBackgroundLayer.h
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASCBackgroundLayer : SKSpriteNode

@property (nonatomic) SKEmitterNode *layer1;
@property (nonatomic) SKEmitterNode *layer2;

-(instancetype) initWithSize:(CGSize) size;

@end
