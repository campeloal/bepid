//
//  PObject.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Physics : NSObject


-(void) addObjectWithTag: (NSString*) tag
                Vertices: (GLfloat*) vertices
             VertexCount: (int) vertexCount
                isConvex: (BOOL) convex
                    Mass: (float) mass
               RotationX: (float) rotationX
               RotationY: (float) rotationY
               RotationZ: (float) rotationZ
                Position: (GLKVector3) position;

- (void)updateWithDelta:(GLfloat)aDelta;
-(GLKVector3)getPositionForObject: (NSString*) tag;
-(float) getRotationXForObject: (NSString*) tag;
-(float) getRotationYForObject: (NSString*) tag;
-(float) getRotationZForObject: (NSString*) tag;

-(void)setPosition:(GLKVector3)position ForObject: (NSString*) tag;
-(void)setRotationX:(float)rotationX ForObject: (NSString*) tag;
-(void)setRotationY:(float)rotationX ForObject: (NSString*) tag;
-(void)setRotationZ:(float)rotationX ForObject: (NSString*) tag;
-(void) setScaleX: (float) scaleX Y: (float) scaleY Z: (float) scaleZ ForObject: (NSString*) tag;

@end
