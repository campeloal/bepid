//
//  ViewController.m
//  iOSShaders
//
//  Created by Alex on 6/3/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "ViewController.h"
#import "Shader.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define INTERPOLATION_FACTOR 0.05

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

@interface ViewController () {
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    float _rotation, interpolatedCoordinate,interpolationFactorAcc;
    GLuint _vertexBuffer;
    
    NSMutableArray *objects;
    Object *object1,*object2,*object3;
    Shader *shader;
    
    GLint uniforms[NUM_UNIFORMS];
    int CURRENT_OBJECT, MAXIMUM_OBJECTS, initialFrame;
    
    GLfloat *vertexArray, *finalVertexArray;
    
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    
    
    CURRENT_OBJECT = 0;
    MAXIMUM_OBJECTS =  (int) [objects count];
    

}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    shader = [[Shader alloc] init];
    [shader loadShadersName:@"gouraud"];
    [shader readParams];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    
    object1 = [[Object alloc] init];
    [object1 loadObj:@"hand_10000"];
    
    objects = [[NSMutableArray alloc] initWithObjects:object1, nil];
    
    vertexArray = [[objects objectAtIndex:0] generateArray];
    
    
    glEnable(GL_DEPTH_TEST);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, NUMBER_POLYGONS*4, vertexArray, GL_DYNAMIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    object2 = [[Object alloc] init];
    [object2 loadObj:@"hand_10000_rot"];
    [objects addObject:object2];
    
    finalVertexArray = [[objects objectAtIndex:1] generateArray];
    interpolationFactorAcc = INTERPOLATION_FACTOR;
    initialFrame = 0;

}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    
    self.effect = nil;
    
    if ([shader program]) {
        glDeleteProgram([shader program]);
        [shader setProgram:0];
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
    
    baseModelViewMatrix = GLKMatrix4Scale(baseModelViewMatrix, 0.5, 0.5, 0.5);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, 3.14, 0.0f, 1.0f, 0.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
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
    float lightColor[4] = {0.53f,0.33f,0.33f,1.0};
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
    
    [self animate:60 isOnLoop: YES];
    glDrawArrays(GL_TRIANGLES, 0, [[objects objectAtIndex:CURRENT_OBJECT] totalNumberVertices]);
}

-(void) animate: (int) frames isOnLoop: (BOOL) isOnLoop
{
    [self interpolateVerticesWithFrames:20];

}

-(void) interpolateVerticesWithFrames: (int) frames
{
    if(initialFrame < frames)
    {
        GLfloat *interpolatedArray = malloc(sizeof(GLfloat)*NUMBER_POLYGONS);
        
        for(int i = 0; i < NUMBER_POLYGONS; i++)
        {
            // Linear Interpolation: ((1-x)A+xB)
            interpolatedCoordinate = (1 - interpolationFactorAcc) * (vertexArray[i]) + (interpolationFactorAcc * finalVertexArray[i]);
            interpolatedArray[i] = interpolatedCoordinate;
        }
        interpolationFactorAcc+=INTERPOLATION_FACTOR;
        glBufferData(GL_ARRAY_BUFFER, NUMBER_POLYGONS*4, interpolatedArray, GL_DYNAMIC_DRAW);
        initialFrame++;
    }
}

@end
