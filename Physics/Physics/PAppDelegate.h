//
//  PAppDelegate.h
//  Physics
//
//  Created by Erik Buck on 6/4/12.
//

#import <GLKit/GLKit.h>
#import "PPhysicsObject.h"
#include "btBulletDynamicsCommon.h"


@interface PAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)physicsUpdateWithElapsedTime:(NSTimeInterval)seconds;

- (void)physicsRegisterBoxObject:(PPhysicsObject *)anObject
                       position:(GLKVector3)position
                           mass:(float)aMass;
- (void)physicsRegisterSphereObject:(PPhysicsObject *)anObject
                       position:(GLKVector3)position
                           mass:(float)aMass;
- (void)physicsUnregisterObject:(PPhysicsObject *)anObject;

- (GLKMatrix4)physicsTransformForObject:(PPhysicsObject *)anObject;
- (GLKVector3)physicsVelocityForObject:(PPhysicsObject *)anObject;
- (void)physicsSetVelocity:(GLKVector3)aVelocity 
                  forObject:(PPhysicsObject *)anObject;
- (GLKVector3)physicsPositionForObject:(PPhysicsObject *)anObject;
- (void)physicsSetPosition:(GLKVector3)aVelocity 
                  forObject:(PPhysicsObject *)anObject;
-(void) setTransformationMatrix: (btRigidBody*) body;

@end
