//
//  RObject.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface RObject : NSObject

@property (nonatomic) GLKMatrix4 modelViewProjectionMatrix;
@property (nonatomic) GLKMatrix3 normalMatrix;
@property (nonatomic) float aspect;
@property (nonatomic) int numberPositionVertices;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float scale;
@property (nonatomic) float *vb;
@property (nonatomic) float *vertCoordinates;
@property (nonatomic) int numberIndices;
@property (nonatomic) int bufferSize;
@property (nonatomic) int vertSize;
@property (nonatomic) BOOL hasTexture;

-(void) createObj:(NSString*) objectName Shader: (NSString*) shaderName;
-(void) drawObject;
-(void) tearDownGL;
-(void) update;

@end
