//
//  RObject.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "RObject.h"
#import "Shader.h"
#import "Object.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    NUM_ATTRIBUTES
};

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    LIGHT_DIR,
    NUM_UNIFORMS
};

@interface RObject(){
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    
    NSMutableArray *objects;
    Object *object;
    Shader *shader;
    
    GLint uniforms[NUM_UNIFORMS];
    GLfloat *vertices;
}

@end

@implementation RObject

- (instancetype)initWithObject: (NSString*) objectName Shader: (NSString*) shaderName
{
    self = [super init];
    if (self) {
        object = [[Object alloc] init];
        [object loadObj:objectName];
        
        shader = [[Shader alloc] init];
        [shader loadShadersName:shaderName];
        [shader readParams];
        
        [self createBuffer];
        
        _position = GLKVector3Make(0, 0, 0);
        _rotationY = 0.0;
        _rotationX = 0.0;
        _rotationZ = 0.0;
        _scale = 1.0;
        

    }
    return self;
}

-(void) createBuffer
{
    GLfloat *ar = [object generateArray];
    
    _numberPositionVertices = [object totalNumberPositionVertices];
    
    glEnable(GL_DEPTH_TEST);
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, NUMBER_POLYGONS*4, ar, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    glBindVertexArrayOES(0);

}

-(void) drawObject
{
    glBindVertexArrayOES(_vertexArray);
    
    glUseProgram([shader program]);
    
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation([shader program], "normalMatrix");
    
    glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
    
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation([shader program], "uMVPMatrix");
    
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
    
    int lightDirAddr = glGetUniformLocation([shader program], "lightDir");
    float lightDir[3] = {1.0f,1.0f,0.0f};
    glUniform3fv(lightDirAddr, 1, lightDir);
    
    int lightPosAddr = glGetUniformLocation([shader program], "lightPos");
    float lightPos[4] = {0.0,0.0,0.0,1};
    glUniform4fv(lightPosAddr, 1, lightPos);
    
    int lightColorAddr = glGetUniformLocation([shader program], "lightColor");
    //float lightColor[4] = {0.53f,0.33f,0.33f,1.0};
    float lightColor[4] = {0.43f,0.23f,0.23f,1.0};
    glUniform4fv(lightColorAddr, 1, lightColor);
    
    int matAmbAddr = glGetUniformLocation([shader program], "matAmbient");
    float matAmb[4] = {1.0,0.5,0.5,1.0};
    glUniform4fv(matAmbAddr, 1, matAmb);
    
    int matDiffAddr = glGetUniformLocation([shader program], "matDiffuse");
    float matDiff[4] = {0.75,0.75,0.75,1.0};
    glUniform4fv(matDiffAddr, 1, matDiff);
    
    int matSpecAddr = glGetUniformLocation([shader program], "matSpecular");
    float matSpec[4] = {1.0,1.0,1.0,1.0};
    glUniform4fv(matSpecAddr, 1, matSpec);
    
    int matShinAddr = glGetUniformLocation([shader program], "matShininess");
    float matShin = 5.0f;
    glUniform1f(matShinAddr, matShin);
    
    
    int eyePosAddr = glGetUniformLocation([shader program], "eyePos");
    float eyePos[3] = {-5.0,0.0,0.0};
    glUniform3fv(eyePosAddr, 1, eyePos);
    
    
    glDrawArrays(GL_TRIANGLES, 0, [object totalNumberVertices]);
    
}

-(void) update
{
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), _aspect, 0.1f, 100.0f);
    
    NSLog(@"rot %f", _rotationX);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4MakeTranslation(self.position.x,self.position.y, self.position.z);
    modelViewMatrix = GLKMatrix4Scale(modelViewMatrix, _scale, _scale, _scale);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationX), 1.0f, 0.0f, 0.0f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationY), 0.0f, 1.0f, 0.0f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationZ), 0.0f, 0.0f, 1.0f);
    
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
}

-(void) tearDownGL
{
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    if ([shader program]) {
        glDeleteProgram([shader program]);
        [shader setProgram:0];
    }

}

-(GLfloat*) getVertices
{
    return [object generateOnlyVertices];
}

@end
