//
//  PPhysicsObject.m
//  Physics
//
//  Created by Erik Buck on 6/4/12.
//

#import "PPhysicsObject.h"

@implementation PPhysicsObject

- (PAxisAllignedBoundingBox)axisAllignedBoundingBox
{
   PAxisAllignedBoundingBox result = 
      {{-0.5f, -0.5f, -0.5f},{0.5f, 0.5f, 0.5f}};
      
   return result;
}


@end
