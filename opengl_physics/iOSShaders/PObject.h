//
//  PObject.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <GLKit/GLKit.h>
//@class btRigidBody;

@interface PObject : NSObject

- (instancetype)initWithName:(const char *)name
                        mass:(float)mass
                      convex:(BOOL)convex
                         tag:(int)tag
                    vertices:(GLfloat *)vertices
                 vertexCount:(unsigned int)vertexCount;


- (void)updateWithDelta:(GLfloat)aDelta;

//-(btRigidBody*) getBody;



@end
