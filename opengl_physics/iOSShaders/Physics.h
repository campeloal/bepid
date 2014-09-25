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
                    Mass: (float) mass;
- (void)updateWithDelta:(GLfloat)aDelta;
-(GLKVector3)positionForObject: (NSString*) tag;
-(float) getRotationXForObject: (NSString*) tag;
-(float) getRotationYForObject: (NSString*) tag;
-(float) getRotationZForObject: (NSString*) tag;
-(void) setInitialRotationX: (float) x ForObject: (NSString*) tag;
-(void) setInitialRotationY: (float) y ForObject: (NSString*) tag;
-(void) setInitialRotationZ: (float) z ForObject: (NSString*) tag;
-(void) setInitialPosition: (GLKVector3) position ForObject: (NSString*) tag;
-(void) setScaleX: (float) scaleX Y: (float) scaleY Z: (float) scaleZ ForObject: (NSString*) tag;

@end
