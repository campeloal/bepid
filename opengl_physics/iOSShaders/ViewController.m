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
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    
    NSMutableArray *objects;
    Object *object;
    Shader *shader;
    
    GLint uniforms[NUM_UNIFORMS];
    
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
    
    object = [[Object alloc] init];
    [object loadObj:@"hand_2500"];
    
    
    [self setupGL];
    
    UIImage *addPressed = [UIImage imageNamed:@"add_press.png"];
    [_addButton setBackgroundImage: addPressed forState: UIControlStateSelected];
    
    UIImage *decPressed = [UIImage imageNamed:@"dec_press.png"];
    [_addButton setBackgroundImage:decPressed forState:UIControlStateSelected];
    
   
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
    
    
    GLfloat *ar = [object generateArray];
    
    _numberPoly.text = [NSString stringWithFormat:@"Number of Polygons: %d", [object totalNumberVertices]/3];
    
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

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
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
    
    //_rotation += self.timeSinceLastUpdate * 0.5f;
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
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
    
    
    glDrawArrays(GL_TRIANGLES, 0, [object totalNumberVertices]);
}


- (IBAction)addPolygons:(id)sender {
    [_addButton setSelected:YES];
}

- (IBAction)decPolygons:(id)sender {
    [_decButton setSelected:YES];
}
@end
