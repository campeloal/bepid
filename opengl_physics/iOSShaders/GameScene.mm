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
#include "btBulletDynamicsCommon.h"

@interface GameScene()
{
        
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;

}

@property (nonatomic) Ball *ball;
@property (nonatomic) Physics *physics;

@end

@implementation GameScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ball = [[Ball alloc] init];
        
        GLfloat *ballVer = [_ball getVertices];
        int ballNumberVer = [_ball numberPositionVertices];
        
        _physics = [[Physics alloc] init];
    
        [_physics addObjectWithTag:@"ball" Vertices:ballVer VertexCount:ballNumberVer isConvex:NO Mass:10.0];
        
        [self setRotationX:0.0 Y:3.14 Z:0.0];
        [self setPosition:GLKVector3Make(0.0, 0.0, -4)];
        [self setScale:1.0];

    }
    return self;
}

-(void) drawObject
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [_ball drawObject];
    
}

-(void) updateRender
{
    _ball.aspect = _aspect;
    _ball.position = [_physics positionForObject:@"ball"];
    _ball.rotationX = [_physics getRotationXForObject:@"ball"];
    _ball.rotationY = [_physics getRotationYForObject:@"ball"];
    _ball.rotationZ = [_physics getRotationZForObject:@"ball"];
    [_ball update];
}

- (void)updatePhysicsWithDelta:(GLfloat)aDelta
{
    [_physics updateWithDelta:aDelta];
}

-(void) tearDownGL
{
    [_ball tearDownGL];

}

-(void) setRotationX: (float) x Y: (float) y Z: (float) z
{
    //Physics
    
    [_physics setInitialRotationX:x ForObject:@"ball"];
    [_physics setInitialRotationY:y ForObject:@"ball"];
    [_physics setInitialRotationZ:z ForObject:@"ball"];
    
    //Render
    _ball.rotationX = x;
    _ball.rotationY = y;
    _ball.rotationZ = z;
    
    
}

-(void) setPosition:(GLKVector3) position
{
    //Physics
    
    [_physics setInitialPosition:position ForObject:@"ball"];
    
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
