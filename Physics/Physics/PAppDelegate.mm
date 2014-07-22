//
//  PAppDelegate.m
//  Physics
//
//  Created by Erik Buck on 6/4/12.
//

#import "PAppDelegate.h"
#include "btBulletDynamicsCommon.h"
#include <map>


typedef std::map<PPhysicsObject *, btCollisionObject*> 
   GModelShapeMap;


@interface PAppDelegate ()
{
   btDefaultCollisionConfiguration *collisionConfiguration;
   btCollisionDispatcher *dispatcher;
   btBroadphaseInterface *overlappingPairCache;
   btSequentialImpulseConstraintSolver *solver;
   btDiscreteDynamicsWorld *dynamicsWorld;
   btAlignedObjectArray<btCollisionShape*> collisionShapes;
   
   GModelShapeMap modelShapeMap;
}

@end


@implementation PAppDelegate

@synthesize window = _window;

#pragma mark - Application delegate methods

/////////////////////////////////////////////////////////////////
// Creates needed physics simulation objects and configures
// properties such as the acceleration of gravity that seldom
// if ever change while the application executes.
- (BOOL)application:(UIApplication *)application 
   didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	///collision configuration contains default setup for memory, 
   // collision setup. Advanced users can create their own 
   // configuration.
	collisionConfiguration = new 
      btDefaultCollisionConfiguration();
   
	///use the default collision dispatcher. For parallel 
   // processing you can use a diffent dispatcher 
   // (see Extras/BulletMultiThreaded)
	dispatcher = new	  
      btCollisionDispatcher(collisionConfiguration);
   
	///btDbvtBroadphase is a good general purpose broadphase. You 
   // can also try out btAxis3Sweep.
	overlappingPairCache = new btDbvtBroadphase();
   
	///the default constraint solver. For parallel processing you 
   // can use a different solver (see Extras/BulletMultiThreaded)
	solver = new btSequentialImpulseConstraintSolver;
   
	dynamicsWorld = 
      new btDiscreteDynamicsWorld(
         dispatcher,
         overlappingPairCache,
         solver,
         collisionConfiguration);
   
	dynamicsWorld->setGravity(btVector3(0,-9.81,0));
   
   return YES;
}

/////////////////////////////////////////////////////////////////
// Cleanup all the physics simulation objects created when the
// application finished launching
- (void)applicationWillTerminate:(UIApplication *)application
{
	//cleanup in the reverse order of creation/initialization
   int i;
   
	//remove the rigid bodies from the dynamics world and delete 
   // them
	for (i=dynamicsWorld->getNumCollisionObjects()-1; i>=0 ;i--)
	{
		btCollisionObject* obj = 
         dynamicsWorld->getCollisionObjectArray()[i];
		btRigidBody* body = btRigidBody::upcast(obj);
		if (body && body->getMotionState())
		{
			delete body->getMotionState();
		}
		dynamicsWorld->removeCollisionObject( obj );
		delete obj;
	}
   
	//delete collision shapes
	for (int j=0;j<collisionShapes.size();j++)
	{
		btCollisionShape* shape = collisionShapes[j];
		collisionShapes[j] = 0;
		delete shape;
	}
   
	//delete dynamics world
	delete dynamicsWorld;
   
	//delete solver
	delete solver;
   
	//delete broadphase
	delete overlappingPairCache;
   
	//delete dispatcher
	delete dispatcher;
   
	delete collisionConfiguration;
   
	//next line is optional: it will be cleared by the destructor 
   // when the array goes out of scope
	collisionShapes.clear();
}


#pragma mark - physics

/////////////////////////////////////////////////////////////////
// Turn the crank on the physics simulation to calculate 
// positions and orientations of collision shapes if
// necessary. The simulation performs up to 32 interpolation
// steps depending on the amount of elapsed time, and each step
// represents 1/120 seconds of elapsed time.
- (void)physicsUpdateWithElapsedTime:(NSTimeInterval)seconds;
{
   dynamicsWorld->stepSimulation(seconds, 32, 1/120.0f);
}


/////////////////////////////////////////////////////////////////
// Add a box shaped collision object to  physics simulation.
- (btRigidBody *)physicsRegisterAABB:
   (PAxisAllignedBoundingBox)aabb
   position:(GLKVector3)position
   mass:(float)aMass;
{
   btCollisionShape *colShape = 
      new btBoxShape(btVector3(
         0.5f * (aabb.max.x - aabb.min.x),
         0.5f * (aabb.max.y - aabb.min.y),
         0.5f * (aabb.max.z - aabb.min.z)));
   
   collisionShapes.push_back(colShape);   
   
   // Create Dynamic Objects
   btTransform startTransform;
   startTransform.setIdentity();
   
   //rigidbody is dynamic if and only if mass is non zero, 
   // otherwise static
   btScalar	mass(aMass);
   btVector3 localInertia(0,0,0);
   if(mass > 0.0f)
   {
      colShape->calculateLocalInertia(mass,localInertia);
   }
   
   startTransform.setOrigin(btVector3(
                                      position.x,
                                      position.y,
                                      position.z));
   
   //using motionstate is recommended, it provides interpolation 
   // capabilities, and only synchronizes 'active' objects
   btDefaultMotionState* myMotionState = 
       new btDefaultMotionState(startTransform);
   btRigidBody::btRigidBodyConstructionInfo rbInfo(
      mass,myMotionState,colShape,localInertia);
   rbInfo.m_restitution = 0.0f;
   rbInfo.m_friction = 0.99f;   
    
   btRigidBody* body = new btRigidBody(rbInfo);
   
   dynamicsWorld->addRigidBody(body);
   
   return body;
}


/////////////////////////////////////////////////////////////////
// Register a box physics object for interaction with
// other objects in the physics simulation.
- (void)physicsRegisterBoxObject:(PPhysicsObject *)anObject
                       position:(GLKVector3)position
                           mass:(float)aMass;
{
   NSParameterAssert(nil != anObject);
   
   PAxisAllignedBoundingBox aabb = 
      anObject.axisAllignedBoundingBox;
   
   modelShapeMap[anObject] = [self physicsRegisterAABB:aabb
                                               position:position
                                                   mass:aMass];
}


/////////////////////////////////////////////////////////////////
// Add a sphere shaped collision object to  physics simulation.
- (btRigidBody *)physicsRegisterSphere:(float)radius
   position:(GLKVector3)position
   mass:(float)aMass;
{
   btCollisionShape* colShape = 
      new btSphereShape(btScalar(radius));
   
   collisionShapes.push_back(colShape);   
   
   // Create Dynamic Objects
   btTransform startTransform;
   startTransform.setIdentity();
   
   //rigidbody is dynamic if and only if mass is non zero, 
   // otherwise static
   btScalar	mass(aMass);
   btVector3 localInertia(0,0,0);
   if(mass > 0.0f)
   {
      colShape->calculateLocalInertia(mass,localInertia);
   }
   
   startTransform.setOrigin(btVector3(
                                      position.x,
                                      position.y,
                                      position.z));
   
   //using motionstate is recommended, it provides interpolation 
   // capabilities, and only synchronizes 'active' objects
   btDefaultMotionState* myMotionState = 
     new btDefaultMotionState(startTransform);
   btRigidBody::btRigidBodyConstructionInfo rbInfo(
     mass,myMotionState,colShape,localInertia);
   rbInfo.m_restitution = 0.0f;
   rbInfo.m_friction = 0.99f;   
    
   btRigidBody* body = new btRigidBody(rbInfo);
   
   dynamicsWorld->addRigidBody(body);
   
   return body;
}


/////////////////////////////////////////////////////////////////
// Register a spherical physics object for interaction with
// other objects in the physics simulation.
- (void)physicsRegisterSphereObject:(PPhysicsObject *)anObject
                       position:(GLKVector3)position
                           mass:(float)aMass;
{
   NSParameterAssert(nil != anObject);
   
   PAxisAllignedBoundingBox aabb = 
      anObject.axisAllignedBoundingBox;
   
   float radius = 0.5f * MAX(MAX(aabb.max.x - aabb.min.x,
      aabb.max.y - aabb.min.y),
      aabb.max.z - aabb.min.z);

   modelShapeMap[anObject] = [self physicsRegisterSphere:radius
      position:position
      mass:aMass];
}


/////////////////////////////////////////////////////////////////
// Unregister and delete the specified registered physics object
// from the physics simulation.
- (void)physicsUnregisterObject:(PPhysicsObject *)anObject
{
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      
		if (body && body->getMotionState())
		{
         btCollisionShape* shape = obj->getCollisionShape();
         collisionShapes.remove(shape);
		   delete shape;
			delete body->getMotionState();
		}
		dynamicsWorld->removeCollisionObject( obj );
		delete obj;
   }
}


/////////////////////////////////////////////////////////////////
// Returns a matrix that completely defines the current position
// and orientation of a registered physics object
- (GLKMatrix4)physicsTransformForObject:(PPhysicsObject *)anObject;
{
   GLKMatrix4 result = GLKMatrix4Identity;
   
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      
//      NSLog(@"physicsTransformForModel:%p", obj);
      
      if(NULL != body)
      {
         btTransform trans;
         body->getMotionState()->getWorldTransform(trans);
         
         result.m00 = trans.getBasis()[0].x();
         result.m01 = trans.getBasis()[0].y();
         result.m02 = trans.getBasis()[0].z();
         result.m10 = trans.getBasis()[1].x();
         result.m11 = trans.getBasis()[1].y();
         result.m12 = trans.getBasis()[1].z();
         result.m20 = trans.getBasis()[2].x();
         result.m21 = trans.getBasis()[2].y();
         result.m22 = trans.getBasis()[2].z();
         result.m30 = -trans.getOrigin().x();
         result.m31 = trans.getOrigin().y();
         result.m32 = -trans.getOrigin().z();
      }
   }
   
   return result;
}


/////////////////////////////////////////////////////////////////
// Returns the velocity of a registered physics object
- (GLKVector3)physicsVelocityForObject:(PPhysicsObject *)anObject;
{
   GLKVector3 result = {0.0f, 0.0f, 0.0f};
   
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      
      if(NULL != body)
      {
         btVector3 velocity = body->getLinearVelocity();
         
         result.x = velocity.x();
         result.y = velocity.y();
         result.z = velocity.z();
      }
   }
   
   return result;
}


/////////////////////////////////////////////////////////////////
// Set the velocity of a registered physics object
- (void)physicsSetVelocity:(GLKVector3)aVelocity 
                  forObject:(PPhysicsObject *)anObject;
{
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      
      //NSLog(@"physicsSetVelocity:%p {%f, %f, %f}", 
      //   obj, aVelocity.x, aVelocity.y, aVelocity.z);
      
      if(NULL != body)
      {
         btVector3 velocity(
            aVelocity.x,
            aVelocity.y,
            aVelocity.z);
         
         body->setLinearVelocity(velocity);
      }
   }
}


/////////////////////////////////////////////////////////////////
// Returns the position of a registered physics object
- (GLKVector3)physicsPositionForObject:(PPhysicsObject *)anObject;
{
   GLKVector3 result = {0.0f, 0.0f, 0.0f};
   
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      
      if(NULL != body)
      {
         btTransform trans;
         body->getMotionState()->getWorldTransform(trans);
         
         result.x = trans.getOrigin().x();
         result.y = trans.getOrigin().y();
         result.z = trans.getOrigin().z();
      }
   }
   
   return result;
}


/////////////////////////////////////////////////////////////////
// Set the position of a registered physics object
- (void)physicsSetPosition:(GLKVector3)aPosition 
                  forObject:(PPhysicsObject *)anObject;
{
   if(1 == modelShapeMap.count(anObject))
   {
      btCollisionObject *obj = modelShapeMap[anObject];
      btRigidBody *body = btRigidBody::upcast(obj);
      float aMass = 1.0f;
      
		if (body && body->getMotionState())
		{
         aMass = body->getInvMass();
			delete body->getMotionState();
		}
		dynamicsWorld->removeCollisionObject( obj );
		delete obj;

      [self physicsRegisterBoxObject:anObject
          position:aPosition 
          mass:aMass];
   }
}

@end
