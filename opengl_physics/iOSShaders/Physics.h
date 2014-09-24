//
//  PObject.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Physics : NSObject


-(void) addObjectWithTag: (int) tag
                Vertices: (GLfloat*) vertices
             VertexCount: (int) vertexCount
                isConvex: (BOOL) convex
                    Mass: (float) mass;
- (void)updateWithDelta:(GLfloat)aDelta;
-(GLKVector3) getPosition;
-(float) getRotationX;
-(float) getRotationY;
-(float) getRotationZ;
-(void) setInitialRotationX: (float) x;
-(void) setInitialRotationY: (float) y;
-(void) setInitialRotationZ: (float) z;
-(void) setInitialPosition: (GLKVector3) position;
-(void) setScaleX: (float) scaleX Y: (float) scaleY Z: (float) scaleZ;

@end
