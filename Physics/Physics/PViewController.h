//
//  PViewController.h
//  Physics
//
//  Created by Erik Buck on 6/4/12.
//

#import <GLKit/GLKit.h>

@interface PViewController : GLKViewController

- (IBAction)takeObjectTypeFrom:(id)sender;
- (IBAction)scheduleAddRandomPhysicsObject:(id)dummy;
- (IBAction)scheduleAddRandomPhysicsSphereObject:(id)dummy; 
- (IBAction)scheduleAddRandomPhysicsBoxObject:(id)dummy;

@end
