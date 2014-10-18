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
@property (nonatomic) Cube *cube;
@property (nonatomic) Physics *physics;

@end

@implementation GameScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ball = [[Ball alloc] init];
        
        _cube = [[Cube alloc] init];
        
        GLfloat *ballVer = [_ball vertCoordinates];
        int ballNumberVer = [_ball vertSize];
        
        GLfloat *cubeVer = [_cube vertCoordinates];
        int cubeNumberVer = [_cube vertSize];
        
        _physics = [[Physics alloc] init];
        
        [self addObject:_ball WithTag:@"ball" Vertices:ballVer VertexCount:ballNumberVer isConvex:YES Mass:10.0 RotationX:0.0 RotationY:0.0 RotationZ:0.0 Position:GLKVector3Make(0.0, 1.3, -4)];
        
        
        [self addObject:_cube WithTag:@"cube" Vertices:cubeVer VertexCount:cubeNumberVer isConvex:YES Mass:0.0 RotationX:M_PI_4*4 RotationY:0.0 RotationZ:0.0 Position:GLKVector3Make(0.0, -1.0, -4)];
    
        [self setScale:1.0];

        

    }
    return self;
}

-(void) addObject:(RObject*) object WithTag: (NSString*) tag Vertices:(GLfloat *)vertices VertexCount:(int)vertexCount isConvex:(BOOL)convex Mass:(float)mass RotationX:(float)rotationX RotationY:(float)rotationY RotationZ:(float)rotationZ Position:(GLKVector3)position
{
    [_physics addObjectWithTag:tag Vertices:vertices VertexCount:vertexCount isConvex:convex Mass:mass RotationX:rotationX RotationY:rotationY RotationZ:rotationZ Position:position];
    
    object.rotationX = rotationX;
    object.rotationY = rotationY;
    object.rotationZ = rotationZ;
    object.position = position;
}

-(void) drawObject
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [_ball drawObject];
    [_cube drawObject];
    
}

-(void) updateRender
{
    _ball.aspect = _aspect;
    _ball.position = [_physics getPositionForObject:@"ball"];
    _ball.rotationX = [_physics getRotationXForObject:@"ball"];
    _ball.rotationY = [_physics getRotationYForObject:@"ball"];
    _ball.rotationZ = [_physics getRotationZForObject:@"ball"];
    
    [_ball update];
    
    _cube.aspect = _aspect;
 //   NSLog(@"physics rotX %f", [_physics getRotationXForObject:@"cube"]);
    _cube.position = [_physics getPositionForObject:@"cube"];
//    _cube.rotationX = [_physics getRotationXForObject:@"cube"];
//    _cube.rotationY = [_physics getRotationYForObject:@"cube"];
//    _cube.rotationZ = [_physics getRotationZForObject:@"cube"];
    
    [_cube update];
}

- (void)updatePhysicsWithDelta:(GLfloat)aDelta
{
    [_physics updateWithDelta:aDelta];
}

-(void) tearDownGL
{
    [_ball tearDownGL];
    [_cube tearDownGL];

}

-(void) setRotationX: (float) x Y: (float) y Z: (float) z
{
    //Physics
    
    [_physics setRotationX:x ForObject:@"cube"];
    [_physics setRotationY:y ForObject:@"cube"];
    [_physics setRotationZ:z ForObject:@"cube"];
    
    //Render
    _ball.rotationX = x;
    _ball.rotationY = y;
    _ball.rotationZ = z;
    
    
}

-(void) increaseRotationX
{
    [_physics setRotationX:_cube.rotationX ForObject:@"cube"];
    
    _cube.rotationX += M_PI_4;
}

-(void) decreaseRotationX
{
    [_physics setRotationX:_cube.rotationX ForObject:@"cube"];
    
    _cube.rotationX -= M_PI_4;
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

-(void) test
{
    [_physics setVelocity:GLKVector3Make(10, 0, 0) forObject:@"ball"];
    NSLog(@"velocity x: %f", [_physics getVelocityForObject:@"ball"].x);
}

@end
