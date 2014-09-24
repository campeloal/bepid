//
//  PObject.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Physics : NSObject

- (instancetype)initWithName:(const char *)name
                        mass:(float)mass
                      convex:(BOOL)convex
                         tag:(int)tag
                    vertices:(GLfloat *)vertices
                 vertexCount:(unsigned int)vertexCount;


- (void)updateWithDelta:(GLfloat)aDelta;
-(GLKVector3) getPosition;
-(float) getRotationX;
-(float) getRotationY;
-(float) getRotationZ;
-(void) setInitialRotationX: (float) x;
-(void) setInitialRotationY: (float) y;
-(void) setInitialRotationZ: (float) z;
-(void) setInitialPosition: (GLKVector3) position;

@end
