//
//  GameScene.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "GameScene.h"
#import "Physics.h"
#import "Ball.h"
#import "Cube.h"
#include "btBulletDynamicsCommon.h"

@interface GameScene()
{
        
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;

}

@property (nonatomic) Ball *ball;
@property (nonatomic) Cube *ball2;
@property (nonatomic) Physics *physics;

@end

@implementation GameScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ball = [[Ball alloc] init];
        
        _ball2 = [[Cube alloc] init];
        
        GLfloat *ballVer = [_ball getVertices];
        int ballNumberVer = [_ball numberPositionVertices];
        
        GLfloat *ball2Ver = [_ball2 getVertices];
        int ball2NumberVer = [_ball2 numberPositionVertices];
        
        _physics = [[Physics alloc] init];
    
        [_physics addObjectWithTag:@"ball" Vertices:ballVer VertexCount:ballNumberVer isConvex:NO Mass:10.0 RotationX:0.0 RotationY:0.0 RotationZ:0.0 Position:GLKVector3Make(0.0, 0.0, -4.0)];
        
        [_physics setRotationY:3.14 ForObject:@"ball"];
        
 //       [_physics addObjectWithTag:@"ball2" Vertices:ball2Ver VertexCount:ball2NumberVer isConvex:NO Mass:50.0 RotationX:90.0 RotationY:0.0 RotationZ:0.0 Position:GLKVector3Make(0.0, 0.0, -4)];
        
 //       _ball2.position = GLKVector3Make(0.0, 50.0, 0.0);
        
//        [self setPosition:GLKVector3Make(0.0, 3.0, -4)];
    
//        [self setScale:1.0];
        
        NSLog(@"porra");

    }
    return self;
}

-(void) drawObject
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [_ball drawObject];
 //   [_ball2 drawObject];
    
}

-(void) updateRender
{
    _ball.aspect = _aspect;
    _ball.position = [_physics getPositionForObject:@"ball"];
    _ball.rotationX = [_physics getRotationXForObject:@"ball"];
    _ball.rotationY = [_physics getRotationYForObject:@"ball"];
    _ball.rotationZ = [_physics getRotationZForObject:@"ball"];
    
    [_ball update];
    
//    _ball2.aspect = _aspect;
//    _ball2.position = [_physics getPositionForObject:@"ball2"];
//    _ball2.rotationX = [_physics getRotationXForObject:@"ball2"];
//    _ball2.rotationY = [_physics getRotationYForObject:@"ball2"];
//    _ball2.rotationZ = [_physics getRotationZForObject:@"ball2"];
//    
//    [_ball2 update];
}

- (void)updatePhysicsWithDelta:(GLfloat)aDelta
{
    [_physics updateWithDelta:aDelta];
}

-(void) tearDownGL
{
    [_ball tearDownGL];
    [_ball2 tearDownGL];

}

-(void) setRotationX: (float) x Y: (float) y Z: (float) z
{
    //Physics
    
    [_physics setRotationX:x ForObject:@"ball"];
    [_physics setRotationY:y ForObject:@"ball"];
    [_physics setRotationZ:z ForObject:@"ball"];
    
    //Render
    _ball.rotationX = x;
    _ball.rotationY = y;
    _ball.rotationZ = z;
    
    
}

-(void) setPosition:(GLKVector3) position
{
    //Physics
    [_physics setPosition:position ForObject:@"ball"];
    
    //Render
    
    _ball.position = position;
}

-(void) setScale: (float) scale
{
    //Physics
    [_physics setScaleX:scale Y:scale Z:scale ForObject:@"ball"];
    
    //Render
    _ball.scale = scale;
    
}

@end
