//
//  PObject.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "PObject.h"
#include "btBulletDynamicsCommon.h"

@interface PObject()
    
@end

@implementation PObject{
    int _tag;
    btCollisionShape* _shape;
    btRigidBody* _body;
    float _rotationX, _rotationY, _rotationZ;
    GLKVector3 _position;
}

- (instancetype)initWithName:(const char *)name
                        mass:(float)mass
                      convex:(BOOL)convex
                         tag:(int)tag
                    vertices:(GLfloat *)vertices
                 vertexCount:(unsigned int)vertexCount
{
    
    self = [super init];
    if (self) {
        
        _tag = tag;
        _position = GLKVector3Make(0, 0, -4);
        _rotationY = 3.14;
        _rotationX = 0.0;
        _rotationZ = 0.0;
        
        
        [self createShapeWithVertices:vertices count:vertexCount isConvex:convex];
        [self createBodyWithMass:mass];
    }
    return self;
}

- (void)dealloc
{
    if (_body)
    {
        delete _body->getMotionState();
        delete _body;
    }
    
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
}

//1
-(void)setPosition:(GLKVector3)position
{
    
    //3
    if (_body)
    {
        btTransform trans = _body->getWorldTransform();
        trans.setOrigin(btVector3(position.x, position.y, position.z));
        _body->setWorldTransform(trans);
    }
}

//4
-(GLKVector3)position
{
        //5
        btTransform trans = _body->getWorldTransform();
        return GLKVector3Make(trans.getOrigin().x(), trans.getOrigin().y(), trans.getOrigin().z());
}

//1
-(void)setRotationX:(float)rotationX
{
    
    if (_body)
    {
        //3
        btTransform trans = _body->getWorldTransform();
        btQuaternion rot = trans.getRotation();
        
        //4
        float angleDiff = rotationX - self.rotationX;
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
        
        float angleDiff = rotationY - self.rotationY;
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
        
        float angleDiff = rotationZ - self.rotationZ;
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

-(btRigidBody*) getBody
{
    return _body;
}

-(void) updateWithDelta:(GLfloat)aDelta
{
    NSLog(@"Ball height: %f", _body->getWorldTransform().getOrigin().getY());
}


@end
