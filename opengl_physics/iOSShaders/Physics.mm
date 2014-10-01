//
//  PObject.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Physics.h"
#include "btBulletDynamicsCommon.h"
#define ROTATION_X 0
#define ROTATION_Y 1
#define ROTATION_Z 2
#define SHAPE 3
#define RIGID_BODY 4

@interface Physics()
    
@end

@implementation Physics{
    NSString* _tag;
    
    btBroadphaseInterface*                  _broadphase;
    btDefaultCollisionConfiguration*        _collisionConfiguration;
    btCollisionDispatcher*                  _dispatcher;
    btSequentialImpulseConstraintSolver*    _solver;
    btDiscreteDynamicsWorld*                _world;
    NSMutableDictionary *_objects;
}

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        _objects = [[NSMutableDictionary alloc] init];
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

-(void) addObjectWithTag: (NSString*) tag
                Vertices: (GLfloat*) vertices
             VertexCount: (int) vertexCount
                isConvex: (BOOL) convex
                    Mass: (float) mass
               RotationX: (float) rotationX
               RotationY: (float) rotationY
               RotationZ: (float) rotationZ
                Position: (GLKVector3) position
{
    _tag = tag;
    
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    [properties addObject:[NSNumber numberWithFloat:rotationX]];
    [properties addObject:[NSNumber numberWithFloat:rotationY]];
    [properties addObject:[NSNumber numberWithFloat:rotationZ]];
    
    btCollisionShape* shape = [self createShapeWithVertices:vertices count:vertexCount isConvex:convex Properties:properties];
    [self createBodyWithPosition:position Mass:mass RotationX:rotationX RotationY:rotationY RotationZ:rotationZ Shape:shape Properties: properties];
    
}

- (void)dealloc
{
//    if (_body)
//    {
//        delete _body->getMotionState();
//        delete _body;
//    }
    delete _world;
    delete _solver;
    delete _collisionConfiguration;
    delete _dispatcher;
    delete _broadphase;
}

-(btCollisionShape*)createShapeWithVertices:(GLfloat *)vertices count:(unsigned int)vertexCount isConvex:(BOOL)convex Properties: (NSMutableArray*) properties
{
    btCollisionShape* shape;
    if (convex)
    {
        int numberCoordinates = 3;
        shape = new btConvexHullShape();
        for (int i = 0; i < vertexCount; i++)
        {
            // i*vertexCount + 0
            btVector3 btv = btVector3(vertices[i*numberCoordinates + 0], vertices[i*numberCoordinates + 1], vertices[i*numberCoordinates + 2]);
            ((btConvexHullShape*)shape)->addPoint(btv);
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
        
        shape = new btBvhTriangleMeshShape(mesh, true);
    }
    
    [properties addObject: [NSValue valueWithPointer:shape]];
    
    return shape;
    
}

-(void)createBodyWithPosition: (GLKVector3) pos Mass:(float)mass RotationX: (float) rotX RotationY: (float) rotY RotationZ: (float) rotZ Shape: (btCollisionShape*) shape Properties: (NSMutableArray*) properties
{
    
    btQuaternion rotation;
    rotation.setEulerZYX(rotZ, rotY, rotX);
    
    btVector3 position = btVector3(pos.x, pos.y, pos.z);
    
    
    btDefaultMotionState* motionState = new btDefaultMotionState(btTransform(rotation, position));
    
    
    btScalar bodyMass = mass;
    btVector3 bodyInertia;
    shape->calculateLocalInertia(bodyMass, bodyInertia);
    
    
    btRigidBody::btRigidBodyConstructionInfo bodyCI = btRigidBody::btRigidBodyConstructionInfo(bodyMass, motionState, shape, bodyInertia);
    
    
    bodyCI.m_restitution = 0.0f;
    bodyCI.m_friction = 0.0f;
    
    
    btRigidBody* body = new btRigidBody(bodyCI);
    
	
    body->setUserPointer((__bridge void*)self);
    
    
    body->setLinearFactor(btVector3(1,1,1));
    
    [properties addObject:[NSValue valueWithPointer:body]];
    
    [_objects setObject:properties forKey:_tag];
    
    _world->addRigidBody(body);
    
}


-(void)setPosition:(GLKVector3)position ForObject: (NSString*) tag
{
    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];

    btTransform trans = localBody->getWorldTransform();
    
    trans.setOrigin(btVector3(position.x, position.y, position.z));
    localBody->setWorldTransform(trans);
}


-(GLKVector3)getPositionForObject: (NSString*) tag
{
    
    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
    
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
    
    btTransform trans = localBody->getWorldTransform();
    return GLKVector3Make(trans.getOrigin().x(), trans.getOrigin().y(), trans.getOrigin().z());
}


-(void)setRotationX:(float)rotationX ForObject: (NSString*) tag
{
    
    NSMutableArray *prop = [_objects valueForKey:tag];
    float oldRotX = [[prop objectAtIndex:ROTATION_X] floatValue];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
    
    btTransform trans = localBody->getWorldTransform();
    btQuaternion rot = trans.getRotation();

    float angleDiff = rotationX - oldRotX;
    btQuaternion diffRot = btQuaternion(btVector3(1,0,0), angleDiff);
    rot = diffRot * rot;
    
    trans.setRotation(rot);
    localBody->setWorldTransform(trans);
}


-(float)getRotationXForObject: (NSString*) tag
{

    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
        
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
        
    btMatrix3x3 rotMatrix = btMatrix3x3(localBody->getWorldTransform().getRotation());
        
    float z,y,x;
    rotMatrix.getEulerZYX(z,y,x);
    return x;

}

-(void)setRotationY:(float)rotationY ForObject: (NSString*) tag
{
    
    NSMutableArray *prop = [_objects valueForKey:tag];
    float oldRotY = [[prop objectAtIndex:ROTATION_Y] floatValue];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
    
    btTransform trans = localBody->getWorldTransform();
    btQuaternion rot = trans.getRotation();
    
    float angleDiff = rotationY - oldRotY;
    btQuaternion diffRot = btQuaternion(btVector3(1,0,0), angleDiff);
    rot = diffRot * rot;
    
    trans.setRotation(rot);
    localBody->setWorldTransform(trans);
}

-(float)getRotationYForObject: (NSString*) tag
{
    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
        
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
        
    btMatrix3x3 rotMatrix = btMatrix3x3(localBody->getWorldTransform().getRotation());
        
    float z,y,x;
    rotMatrix.getEulerZYX(z,y,x);
    return y;
}

-(void)setRotationZ:(float)rotationZ ForObject: (NSString*) tag
{
    NSMutableArray *prop = [_objects valueForKey:tag];
    float oldRotZ = [[prop objectAtIndex:ROTATION_Z] floatValue];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
    
    btTransform trans = localBody->getWorldTransform();
    btQuaternion rot = trans.getRotation();
    
    float angleDiff = rotationZ - oldRotZ;
    btQuaternion diffRot = btQuaternion(btVector3(1,0,0), angleDiff);
    rot = diffRot * rot;
    
    trans.setRotation(rot);
    localBody->setWorldTransform(trans);
}

-(float)getRotationZForObject: (NSString*) tag
{

    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *bodyValue = [prop objectAtIndex:RIGID_BODY];
        
    btRigidBody* localBody = (btRigidBody*)[bodyValue pointerValue];
        
    btMatrix3x3 rotMatrix = btMatrix3x3(localBody->getWorldTransform().getRotation());
        
    float z,y,x;
    rotMatrix.getEulerZYX(z,y,x);
    return z;
}

-(void) updateWithDelta:(GLfloat)aDelta
{
    _world->stepSimulation(aDelta);
    
//    btRigidBody* localBody;
//    
//    for(id obj in _objects) {
//        NSMutableArray *prop = [_objects objectForKey:obj];
//        NSValue *bodyValue = [prop objectAtIndex:4];
//        localBody = (btRigidBody*)[bodyValue pointerValue];
//        
//        float posX = localBody->getWorldTransform().getOrigin().getX();
//        float posY = localBody->getWorldTransform().getOrigin().getY();
//        float posZ = localBody->getWorldTransform().getOrigin().getZ();
//        
//        
//    }
    
}


-(void) setScaleX: (float) scaleX Y: (float) scaleY Z: (float) scaleZ ForObject: (NSString*) tag
{
    NSMutableArray *prop = [_objects valueForKey:tag];
    NSValue *shapeValue = [prop objectAtIndex:SHAPE];
    btCollisionShape* localShape = (btCollisionShape*)[shapeValue pointerValue];

    localShape->setLocalScaling(btVector3(scaleX, scaleY, scaleZ));
}
@end
