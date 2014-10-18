//
//  GameScene.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface GameScene : NSObject

@property (nonatomic) float aspect;

-(void) tearDownGL;
-(void) drawObject;
-(void) updateRender;
- (void)updatePhysicsWithDelta:(GLfloat)aDelta;
-(void) increaseRotationX;
-(void) decreaseRotationX;
-(void) test;

@end
