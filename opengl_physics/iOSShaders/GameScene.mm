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
        
        GLfloat *vertices = [_ball.render getVertices];
        int numberVertices = [_ball.render numberPositionVertices];
        
        _physics = [[Physics alloc] initWithName:"ball" mass:10.0 convex:NO tag: 1 vertices: vertices vertexCount: numberVertices];
        
        [self setRotationX:0.0 Y:3.14 Z:0.0];
        [self setPosition:GLKVector3Make(0.0, 0.0, -4)];

    }
    return self;
}

-(void) drawObject
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [_ball.render drawObject];
    
}

-(void) updateRender
{
    _ball.render.aspect = _aspect;
    _ball.render.position = [_physics getPosition];
    _ball.render.rotationX = [_physics getRotationX];
    _ball.render.rotationY = [_physics getRotationY];
    _ball.render.rotationZ = [_physics getRotationZ];
    [_ball.render update];
}

- (void)updatePhysicsWithDelta:(GLfloat)aDelta
{
    [_physics updateWithDelta:aDelta];
}

-(void) tearDownGL
{
    [_ball.render tearDownGL];

}

-(void) setRotationX: (float) x Y: (float) y Z: (float) z
{
    //Physics
    
    [_physics setInitialRotationX:x];
    [_physics setInitialRotationY:y];
    [_physics setInitialRotationZ:z];
    
    //Render
    _ball.render.rotationX = x;
    _ball.render.rotationY = y;
    _ball.render.rotationZ = z;
    
    
}

-(void) setPosition:(GLKVector3) position
{
    //Physics
    
    [_physics setInitialPosition:position];
    
    //Render
    
    _ball.render.position = position;
}

@end
