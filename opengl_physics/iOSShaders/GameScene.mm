//
//  GameScene.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "GameScene.h"
#import "RObject.h"
#import "Ball.h"
#include "btBulletDynamicsCommon.h"

@interface GameScene()
{
        
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    RObject *rObject;
    
    btBroadphaseInterface*                  _broadphase;
    btDefaultCollisionConfiguration*        _collisionConfiguration;
    btCollisionDispatcher*                  _dispatcher;
    btSequentialImpulseConstraintSolver*    _solver;
    btDiscreteDynamicsWorld*                _world;
}

@property (nonatomic) Ball *ball;

@end

@implementation GameScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ball = [[Ball alloc] init];
        [self initPhysics];
        
    }
    return self;
}

-(void)initPhysics
{

    _broadphase = new btDbvtBroadphase();
    

    _collisionConfiguration = new btDefaultCollisionConfiguration();
    _dispatcher = new btCollisionDispatcher(_collisionConfiguration);
    

    _solver = new btSequentialImpulseConstraintSolver();
    

    _world = new btDiscreteDynamicsWorld(_dispatcher, _broadphase, _solver, _collisionConfiguration);
    

    _world->setGravity(btVector3(0, -9.8, 0));
    
    
}


- (void)dealloc
{
    delete _world;
    delete _solver;
    delete _collisionConfiguration;
    delete _dispatcher;
    delete _broadphase;
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
    [_ball.render update];
}

- (void)updatePhysicsWithDelta:(GLfloat)aDelta
{
    _world->stepSimulation(aDelta);
    [_ball.physhics updateWithDelta:aDelta];
}

-(void) tearDownGL
{
    [_ball.render tearDownGL];

}

@end
