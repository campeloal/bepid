//
//  RObject.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/23/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "RObject.h"
#import "Shader.h"

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
    GLuint _texture,_textureAddr;
    
    NSMutableArray *objects;
    Shader *shader;
    
    GLint uniforms[NUM_UNIFORMS];
    GLfloat *vertices;
}

@end

@implementation RObject


-(void) createObj:(NSString*) objectName Shader: (NSString*) shaderName
{
    
    shader = [[Shader alloc] init];
    [shader loadShadersName:shaderName];
    
    [self createBuffer];
    
    [shader readParams];
    
    glUseProgram([shader program]);
    
    if (_hasTexture) {
        _texture = [self setupTexture:@"add.png"];
//        _textureAddr = glGetAttribLocation([shader program], "textCoord");
//        glEnableVertexAttribArray(_textureAddr);
    }
    
    
    _position = GLKVector3Make(0, 0, 0);
    _rotationY = 0.0;
    _rotationX = 0.0;
    _rotationZ = 0.0;
    _scale = 1.0;
}

-(void) createBuffer
{
    GLfloat *ar = _vb;
    
    glEnable(GL_DEPTH_TEST);
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, _bufferSize*sizeof(float), ar, GL_STATIC_DRAW);
    
    glBindAttribLocation([shader program], GLKVertexAttribPosition, "position");
    glBindAttribLocation([shader program], GLKVertexAttribNormal, "normal");
    
    int numberCoordinates = 0; 
    
    if (_hasTexture) {
        numberCoordinates = 8; //3 positions + 3 normals + 2 textures
        glBindAttribLocation([shader program], GLKVertexAttribTexCoord0, "textCoord");
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, numberCoordinates*sizeof(float), BUFFER_OFFSET(6*sizeof(float)));
    }
    else
    {
        numberCoordinates = 6; //3 positions + 3 normals
    }
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, numberCoordinates*sizeof(float), BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, numberCoordinates*sizeof(float), BUFFER_OFFSET(3*sizeof(float)));
    
    glBindVertexArrayOES(_vertexArray);

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
    
    if (_hasTexture) {
        
        //glVertexAttribPointer(_textureAddr, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
        
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, _texture);
        
        int texAddr = glGetUniformLocation([shader program], "texture");
        glUniform1i(texAddr, 0);
        
    
    }
    
    glDrawArrays(GL_TRIANGLES, 0, _numberIndices);
    
}

-(void) update
{
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), _aspect, 0.1f, 100.0f);
    
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

- (GLuint)setupTexture:(NSString *)fileName {
    // 1
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    // 2
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    // 4
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    free(spriteData);        
    return texName;    
}


@end
