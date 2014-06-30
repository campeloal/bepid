//
//  ASCMyScene.h
//  VolleyballGame
//

//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASCMyScene : SKScene<SKPhysicsContactDelegate>

@property CGPoint currentLocation;

-(void) jump;

@end
