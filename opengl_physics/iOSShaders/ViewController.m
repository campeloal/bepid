//
//  ViewController.m
//  iOSShaders
//
//  Created by Alex on 6/3/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "ViewController.h"
#import "RObject.h"
#import "GameScene.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))


@interface ViewController () {
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    RObject *rObject;
    
}
@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic) GameScene *gameScene;

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

}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    _gameScene = [[GameScene alloc] init];

}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [_gameScene tearDownGL];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    _gameScene.aspect = aspect;
    [_gameScene updatePhysicsWithDelta:3.5];
    [_gameScene updateRender];
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
    [_gameScene drawObject];
    
}

@end
