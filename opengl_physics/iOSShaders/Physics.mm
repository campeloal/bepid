//
//  PObject.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Physics.h"
#include "btBulletDynamicsCommon.h"

@interface Physics()
    
@end

@implementation Physics{
    int _tag;
    btCollisionShape* _shape;
    btRigidBody* _body;
    float _rotationX, _rotationY, _rotationZ;
    GLKVector3 _position;
    
    btBroadphaseInterface*                  _broadphase;
    btDefaultCollisionConfiguration*        _collisionConfiguration;
    btCollisionDispatcher*                  _dispatcher;
    btSequentialImpulseConstraintSolver*    _solver;
    btDiscreteDynamicsWorld*                _world;
    NSMutableArray *physProperties;
    NSDictionary *_objects;
}

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
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

-(void) addObjectWithTag: (int) tag
                Vertices: (GLfloat*) vertices
             VertexCount: (int) vertexCount
                isConvex: (BOOL) convex
                    Mass: (float) mass
{
    _tag = tag;
    _position = GLKVector3Make(0, 0, -4);
    _rotationY = 3.14;
    _rotationX = 0.0;
    _rotationZ = 0.0;
    _objects = [[NSDictionary alloc] init];
    
    [self createShapeWithVertices:vertices count:vertexCount isConvex:convex];
    [self createBodyWithMass:mass];
}

- (void)dealloc
{
    if (_body)
    {
        delete _body->getMotionState();
        delete _body;
    }
    delete _world;
    delete _solver;
    delete _collisionConfiguration;
    delete _dispatcher;
    delete _broadphase;
    delete _shape;
}

-(void)createShapeWithVertices:(GLfloat *)vertices count:(unsigned int)vertexCount isConvex:(BOOL)convex
{
    //1
    if (convex)
    {
        int numberCoordinates = 3;
        _shape = new btConvexHullShape();
        for (int i = 0; i < vertexCount; i++)
        {
            // i*vertexCount + 0
            btVector3 btv = btVector3(vertices[i*numberCoordinates + 0], vertices[i*numberCoordinates + 1], vertices[i*numberCoordinates + 2]);
            ((btConvexHullShape*)_shape)->addPoint(btv);
        }
    }
    else
    {
        int numberVertices = 9;
        btTriangleMesh* mesh = new btTriangleMesh();
        for (int i=0; i < vertexCount; i ++)
        {
            GLfloat v1c1 = vertices[i*numberVertices + 0];
            GLfloat v1c2 = vertices[i*numberVertices + 1];
            GLfloat v1c3 = vertices[i*numberVertices + 2];
            
            GLfloat v2c1 = vertices[i*numberVertices + 3];
            GLfloat v2c2 = vertices[i*numberVertices + 4];
            GLfloat v2c3 = vertices[i*numberVertices + 5];
            
            GLfloat v3c1 = vertices[i*numberVertices + 6];
            GLfloat v3c2 = vertices[i*numberVertices + 7];
            GLfloat v3c3 = vertices[i*numberVertices + 8];
            
            btVector3 bv1 = btVector3(v1c1, v1c2, v1c3);
            btVector3 bv2 = btVector3(v2c1, v2c2, v2c3);
            btVector3 bv3 = btVector3(v3c1, v3c2, v3c3);
            
            mesh->addTriangle(bv1, bv2, bv3);
        }
        
        _shape = new btBvhTriangleMeshShape(mesh, true);
        
    }
    
}

-(void)createBodyWithMass:(float)mass
{
    
    btQuaternion rotation;
    rotation.setEulerZYX(_rotationZ, _rotationY, _rotationX);
    
    
    btVector3 position = btVector3(_position.x, _position.y, _position.z);
    
    
    btDefaultMotionState* motionState = new btDefaultMotionState(btTransform(rotation, position));
    
    
    btScalar bodyMass = mass;
    btVector3 bodyInertia;
    _shape->calculateLocalInertia(bodyMass, bodyInertia);
    
    
    btRigidBody::btRigidBodyConstructionInfo bodyCI = btRigidBody::btRigidBodyConstructionInfo(bodyMass, motionState, _shape, bodyInertia);
    
    
    bodyCI.m_restitution = 1.0f;
    bodyCI.m_friction = 0.5f;
    
    
    _body = new btRigidBody(bodyCI);
    
	
    _body->setUserPointer((__bridge void*)self);
    
    
    _body->setLinearFactor(btVector3(1,1,1));
    
    _world->addRigidBody(_body);
}


-(void)setPosition:(GLKVector3)position
{
    
    if (_body)
    {
        btTransform trans = _body->getWorldTransform();
        trans.setOrigin(btVector3(position.x, position.y, position.z));
        _body->setWorldTransform(trans);
    }
}


-(GLKVector3)position
{
    
        btTransform trans = _body->getWorldTransform();
        return GLKVector3Make(trans.getOrigin().x(), trans.getOrigin().y(), trans.getOrigin().z());
}


-(void)setRotationX:(float)rotationX
{
    
    if (_body)
    {
        //3
        btTransform trans = _body->getWorldTransform();
        btQuaternion rot = trans.getRotation();
        
        //4
        float angleDiff = rotationX - _rotationX;
        btQuaternion diffRot = btQuaternion(btVector3(1,0,0), angleDiff);
        rot = diffRot * rot;
        
        //5
        trans.setRotation(rot);
        _body->setWorldTransform(trans);
    }
}


-(float)rotationX
{
    if (_body)
    {
        //7
        btMatrix3x3 rotMatrix = btMatrix3x3(_body->getWorldTransform().getRotation());
        float z,y,x;
        rotMatrix.getEulerZYX(z,y,x);
        return x;
    }
    
    return -1;

}

-(void)setRotationY:(float)rotationY
{
    
    if (_body)
    {
        btTransform trans = _body->getWorldTransform();
        btQuaternion rot = trans.getRotation();
        
        float angleDiff = rotationY - _rotationY;
        btQuaternion diffRot = btQuaternion(btVector3(0,1,0), angleDiff);
        rot = diffRot * rot;
        
        trans.setRotation(rot);
        _body->setWorldTransform(trans);
    }
}

-(float)rotationY
{
    if (_body)
    {
        btMatrix3x3 rotMatrix = btMatrix3x3(_body->getWorldTransform().getRotation());
        float z,y,x;
        rotMatrix.getEulerZYX(z,y,x);
        return y;
    }
    
    return -1;
    
}

-(void)setRotationZ:(float)rotationZ
{
    
    if (_body)
    {
        btTransform trans = _body->getWorldTransform();
        btQuaternion rot = trans.getRotation();
        
        float angleDiff = rotationZ - _rotationZ;
        btQuaternion diffRot = btQuaternion(btVector3(0,0,1), angleDiff);
        rot = diffRot * rot;
        
        trans.setRotation(rot);
        _body->setWorldTransform(trans);
        
    }
}

-(float)rotationZ
{
    if (_body)
    {
        btMatrix3x3 rotMatrix = btMatrix3x3(_body->getWorldTransform().getRotation());
        float z,y,x;
        rotMatrix.getEulerZYX(z,y,x);
        return z;
    }
    
    return -1;
}

-(void) updateWithDelta:(GLfloat)aDelta
{
    _world->stepSimulation(aDelta);
    
    float posX = _body->getWorldTransform().getOrigin().getX();
    float posY = _body->getWorldTransform().getOrigin().getY();
    float posZ = _body->getWorldTransform().getOrigin().getZ();
    
    _position.x = posX;
    _position.y = posY;
    _position.z = posZ;
    
}

-(GLKVector3) getPosition
{
    return _position;
}

-(float) getRotationX
{
    return _rotationX;
}

-(float) getRotationY
{
    return _rotationY;
}

-(float) getRotationZ
{
    return _rotationZ;
}

-(void) setInitialRotationX: (float) x
{
    _rotationX = x;
}

-(void) setInitialRotationY: (float) y
{
    _rotationX = y;
}

-(void) setInitialRotationZ: (float) z
{
    _rotationZ = z;
}

-(void) setInitialPosition: (GLKVector3) position
{
    _position.x = position.x;
    _position.y = position.y;
    _position.z = position.z;
}

-(void) setScaleX: (float) scaleX Y: (float) scaleY Z: (float) scaleZ
{
    _shape->setLocalScaling(btVector3(scaleX, scaleY, scaleZ));
}
@end
