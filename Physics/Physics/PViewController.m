//
//  PViewController.m
//  Physics
//
//  Created by Erik Buck on 6/4/12.
//

#import "PViewController.h"
#import "PPhysicsObject.h"
#import "PAppDelegate.h"
#import "cube.h"
#import "sphere.h"


static const NSInteger PMAX_NUMBER_BLOCKS = 30;


@interface PViewController ()

@property (strong, nonatomic, readwrite)
   GLKBaseEffect *baseEffect;
@property (strong, nonatomic, readwrite) 
   NSMutableArray *boxPhysicsObjects;
@property (strong, nonatomic, readwrite) 
   NSMutableArray *spherePhysicsObjects;
@property (strong, nonatomic, readwrite) 
   NSMutableArray *immovableBoxPhysicsObjects;
   
@end


@implementation PViewController

@synthesize baseEffect = baseEffect_;
@synthesize boxPhysicsObjects = boxPhysicsObjects_;
@synthesize spherePhysicsObjects = spherePhysicsObjects_;
@synthesize immovableBoxPhysicsObjects = immovableBoxPhysicsObjects_;


/////////////////////////////////////////////////////////////////
// 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Physics

/////////////////////////////////////////////////////////////////
// Add a grid of immovable box objects to simulate a floor that
// supports other objects.
- (void)addImmovableBoxPhysicsObjects
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   for(int i = -2; i < 3; i++)
   {
      for(int j = -2; j < 3; j++)
      {
         PPhysicsObject *anObject = [[PPhysicsObject alloc] init];
         [self.immovableBoxPhysicsObjects addObject:anObject];
         
         [appDelegate physicsRegisterBoxObject:anObject
             position:GLKVector3Make(i * 1.3f, -1.0f, j  * 1.4f) 
             mass:0.0f]; // Objects with zero mass are immovable
       }
   }
}


/////////////////////////////////////////////////////////////////
// Add a sphere object with random initial velocity to the 
// simulation.
- (void)addRandomPhysicsSphereObject
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
      
   PPhysicsObject *anObject = nil;
   
   if([self.spherePhysicsObjects count] < PMAX_NUMBER_BLOCKS)
   {
      anObject = [[PPhysicsObject alloc] init];
   }
   else 
   {
      anObject = [self.spherePhysicsObjects objectAtIndex:0];
      [self.spherePhysicsObjects removeObjectAtIndex:0];
   }

   [self.spherePhysicsObjects addObject:anObject];

   [appDelegate physicsRegisterSphereObject:anObject
       position:GLKVector3Make(0,7.0,0) 
       mass:2.0f];
   
   [appDelegate physicsSetVelocity:GLKVector3Make(
          random() / (float)RAND_MAX * 2.0f - 1.0f,
          0.0f, 
          random() /(float)RAND_MAX * 2.0f - 1.0f) 
       forObject:anObject];
}


/////////////////////////////////////////////////////////////////
// Add a box object with random initial velocity to the 
// simulation.
- (void)addRandomPhysicsBoxObject
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
      
   PPhysicsObject *anObject = nil;
   
   if([self.boxPhysicsObjects count] < PMAX_NUMBER_BLOCKS)
   {
      anObject = [[PPhysicsObject alloc] init];
   }
   else 
   {
      anObject = [self.boxPhysicsObjects objectAtIndex:0];
      [self.boxPhysicsObjects removeObjectAtIndex:0];
   }

   [self.boxPhysicsObjects addObject:anObject];

   [appDelegate physicsRegisterBoxObject:anObject
       position:GLKVector3Make(0,7.0,0) 
       mass:2.0f];
   
   [appDelegate physicsSetVelocity:GLKVector3Make(
          random() / (float)RAND_MAX * 2.0f - 1.0f,
          0.0f, 
          random() /(float)RAND_MAX * 2.0f - 1.0f) 
       forObject:anObject];
}


/////////////////////////////////////////////////////////////////
// Randomly add either a box object or a sphere object to the 
// simulation
- (void)addRandomPhysicsObject
{
   if(random() % 2 == 0)
   {
      [self addRandomPhysicsBoxObject];
   }
   else
   {
      [self addRandomPhysicsSphereObject];
   }
}


#pragma mark - GLKView update & drawing

/////////////////////////////////////////////////////////////////
// Remove objects that have fallen out of view from the physics
// simulation
- (void)removeOutOfViewObjects
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   // Remove box objects that have fallen out of view
   for(PPhysicsObject *currentObject in [self.boxPhysicsObjects copy])
   {
      GLKVector3 objectPosition =
         [appDelegate physicsPositionForObject:currentObject];
      
      if(objectPosition.y < -15.0f)
      {  
         [appDelegate physicsUnregisterObject:currentObject];
         [self.boxPhysicsObjects removeObject:currentObject];
      }
   }

   // Remove sphere objects that have fallen out of view
   for(PPhysicsObject *currentObject in [self.spherePhysicsObjects copy])
   {
      GLKVector3 objectPosition =
         [appDelegate physicsPositionForObject:currentObject];
      
      if(objectPosition.y < -15.0f)
      {  
         [appDelegate physicsUnregisterObject:currentObject];
         [self.spherePhysicsObjects removeObject:currentObject];
      }
   }
}


/////////////////////////////////////////////////////////////////
// This method is called automatically at the update rate of the 
// receiver (default 30 Hz). This method is implemented to
// update the physics simulation and remove any simulated objects
// that have fallen out of view.
- (void)update
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   [appDelegate physicsUpdateWithElapsedTime:
      self.timeSinceLastUpdate];

   // Remove objects that have fallen out of view from the 
   // physics simulation
   [self removeOutOfViewObjects];
}


/////////////////////////////////////////////////////////////////
// Draw all the box objects currently being simulated
- (void)drawPhysicsBoxObjects
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   // Save the current modelview matrix
   GLKMatrix4 savedModelviewMatrix = 
      self.baseEffect.transform.modelviewMatrix;
      
   // Enable use of positions 
   glEnableVertexAttribArray(      
      GLKVertexAttribPosition);
      
   glVertexAttribPointer(          
      GLKVertexAttribPosition, 
      3,                   // three components per vertex
      GL_FLOAT,            // data is floating point
      GL_FALSE,            // no fixed point scaling
      3 * sizeof(float), // no gaps in data
      cubeVerts);
   
   // Enable use of normals 
   glEnableVertexAttribArray(      
      GLKVertexAttribNormal);
      
   glVertexAttribPointer(          
      GLKVertexAttribNormal, 
      3,                   // three components per vertex
      GL_FLOAT,            // data is floating point
      GL_FALSE,            // no fixed point scaling
      3 * sizeof(float), // no gaps in data
      cubeNormals);

   for(PPhysicsObject *currentObject in self.boxPhysicsObjects)
   {
      self.baseEffect.transform.modelviewMatrix = 
         GLKMatrix4Multiply(savedModelviewMatrix,   
            [appDelegate physicsTransformForObject:currentObject]);
      
      [self.baseEffect prepareToDraw];  
         
      // Draw triangles using the first three vertices in the 
      // currently bound vertex buffer
      glDrawArrays(GL_TRIANGLES, 
         0,  // Start with first vertex in currently bound buffer
         cubeNumVerts);
   }
   
   // Draw all of the immovable objects in the simulation
   self.baseEffect.light0.diffuseColor = 
      GLKVector4Make(
         0.0f, // Red 
         0.7f, // Green 
         0.0f, // Blue 
         1.0f);// Alpha   
          
   for(PPhysicsObject *currentObject in self.immovableBoxPhysicsObjects)
   {
      self.baseEffect.transform.modelviewMatrix = 
         GLKMatrix4Multiply(savedModelviewMatrix,   
            [appDelegate physicsTransformForObject:currentObject]);
      
      [self.baseEffect prepareToDraw];  
         
      // Draw triangles using the first three vertices in the 
      // currently bound vertex buffer
      glDrawArrays(GL_TRIANGLES, 
         0,  // Start with first vertex in currently bound buffer
         cubeNumVerts);
   }
   
   // Restore the current modelview matrix
   self.baseEffect.transform.modelviewMatrix = 
      savedModelviewMatrix;
}


/////////////////////////////////////////////////////////////////
// Draw all the sphere objects currently being simulated
- (void)drawPhysicsSphereObjects
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   // Save the current modelview matrix
   GLKMatrix4 savedModelviewMatrix = 
      self.baseEffect.transform.modelviewMatrix;

   // Draw all of the movable objects in the simulation
   self.baseEffect.light0.diffuseColor = 
      GLKVector4Make(
         1.0f, // Red 
         1.0f, // Green 
         1.0f, // Blue 
         1.0f);// Alpha    
   
   // Enable use of positions 
   glEnableVertexAttribArray(      
      GLKVertexAttribPosition);
      
   glVertexAttribPointer(          
      GLKVertexAttribPosition, 
      3,                   // three components per vertex
      GL_FLOAT,            // data is floating point
      GL_FALSE,            // no fixed point scaling
      3 * sizeof(float), // no gaps in data
      sphereVerts);
   
   // Enable use of normals 
   glEnableVertexAttribArray(      
      GLKVertexAttribNormal);
      
   glVertexAttribPointer(          
      GLKVertexAttribNormal, 
      3,                   // three components per vertex
      GL_FLOAT,            // data is floating point
      GL_FALSE,            // no fixed point scaling
      3 * sizeof(float), // no gaps in data
      sphereNormals);
   for(PPhysicsObject *currentObject in self.spherePhysicsObjects)
   {
      self.baseEffect.transform.modelviewMatrix = 
         GLKMatrix4Multiply(savedModelviewMatrix,   
            [appDelegate physicsTransformForObject:currentObject]);
      
      [self.baseEffect prepareToDraw];  
         
      // Draw triangles using the first three vertices in the 
      // currently bound vertex buffer
      glDrawArrays(GL_TRIANGLES, 
         0,  // Start with first vertex in currently bound buffer
         sphereNumVerts);
   }
   
   // Restore the current modelview matrix
   self.baseEffect.transform.modelviewMatrix = 
      savedModelviewMatrix;
}
      

/////////////////////////////////////////////////////////////////
// GLKView delegate method: Called by the view controller's view
// whenever Cocoa Touch asks the view controller's view to
// draw itself. (In this case, render into a frame buffer that
// shares memory with a Core Animation Layer)
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
   // Calculate the aspect ratio for the scene and setup a 
   // perspective projection
   const GLfloat  aspectRatio = 
   (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;
   
   // Set the projection to match the aspect ratio
   self.baseEffect.transform.projectionMatrix = 
   GLKMatrix4MakePerspective(
      GLKMathDegreesToRadians(35.0f),// Standard field of view
      aspectRatio,
      0.2f,     // Don't make near plane too close
      200.0f); // Far arbitrarily far enough to contain scene
   
   // Configure a light
   self.baseEffect.light0.position = 
   GLKVector4Make(
      0.6f, 
      1.0f, 
      0.4f,  
      0.0f);// Directional light
      
   [self.baseEffect prepareToDraw];

   // Clear Frame Buffer (erase previous drawing)
   glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
   
   [self drawPhysicsSphereObjects];
   [self drawPhysicsBoxObjects];      
}

#pragma mark - View lifecycle

/////////////////////////////////////////////////////////////////
// Setup initial controller and OpenGL ES state for properties
// that seldom id ever change while the application executes.
- (void)viewDidLoad
{
   [super viewDidLoad];
   
   // Create collection to store physics objects
   self.boxPhysicsObjects = [NSMutableArray array];
   self.spherePhysicsObjects = [NSMutableArray array];
   self.immovableBoxPhysicsObjects = [NSMutableArray array];
   
   // Verify the type of view created automatically by the
   // Interface Builder storyboard
   GLKView *view = (GLKView *)self.view;
   NSAssert([view isKindOfClass:[GLKView class]],
      @"View controller's view is not a GLKView");
   
   // Use high resolution depth buffer
   view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
   
   // Create an OpenGL ES 2.0 context and provide it to the
   // view
   view.context = [[EAGLContext alloc] 
      initWithAPI:kEAGLRenderingAPIOpenGLES2];
   
   // Make the new context current
   [EAGLContext setCurrentContext:view.context];
   
   // Create a base effect that provides standard OpenGL ES 2.0
   // Shading Language programs and set constants to be used for 
   // all subsequent rendering
   self.baseEffect = [[GLKBaseEffect alloc] init];
   
   glEnable(GL_CULL_FACE);
   glEnable(GL_DEPTH_TEST);
   
   // Set the background color stored in the current context 
   glClearColor(0.0f, 0.0f, 0.0f, 1.0f); // background color
   
   // Configure initial modelview matrix
   self.baseEffect.transform.modelviewMatrix =  
      GLKMatrix4MakeLookAt(
         9.8, 9.8, 6.0, // Eye position
         0.0, 1.0, 0.0,  // Look-at position
         0.0, 1.0, 0.0); // Up direction

   // Configure a light
   self.baseEffect.light0.enabled = GL_TRUE;
   self.baseEffect.light0.ambientColor = 
      GLKVector4Make(
         0.7f, // Red 
         0.7f, // Green 
         0.7f, // Blue 
         1.0f);// Alpha 
   
   // Add some immovable objects
   [self addImmovableBoxPhysicsObjects];
   
   // Start adding objects to physics simulation   
   [self scheduleAddRandomPhysicsSphereObject:nil];
   
   // Become the first responder to receive motion events
   [self becomeFirstResponder];
}


- (void)viewDidUnload
{   
   // Make the view's context current
   GLKView *view = (GLKView *)self.view;
   [EAGLContext setCurrentContext:view.context];
    
   // Stop using the context created in -viewDidLoad
   ((GLKView *)self.view).context = nil;
   [EAGLContext setCurrentContext:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
   return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Actions

/////////////////////////////////////////////////////////////////
// 
- (IBAction)takeObjectTypeFrom:(UISegmentedControl *)sender 
{
   NSInteger index = sender.selectedSegmentIndex;
   
   switch(index)
   {
      case 2:
      {
         [self scheduleAddRandomPhysicsObject:nil];
         break;
      }   
      case 1:
      {
         [self scheduleAddRandomPhysicsBoxObject:nil];
         break;
      }   
      case 0:
      default:
      {
         [self scheduleAddRandomPhysicsSphereObject:nil];
         break;
      }  
   }
   
   // Become the first responder to receive motion events
   [self becomeFirstResponder];
}


/////////////////////////////////////////////////////////////////
// 
- (IBAction)scheduleAddRandomPhysicsObject:(id)dummy
{
   [[self class] cancelPreviousPerformRequestsWithTarget:self];
   
   [self addRandomPhysicsObject];
   
   [self performSelector:
      @selector(scheduleAddRandomPhysicsObject:) 
      withObject:nil afterDelay:1.0];
}


/////////////////////////////////////////////////////////////////
// 
- (IBAction)scheduleAddRandomPhysicsSphereObject:(id)dummy
{
   [[self class] cancelPreviousPerformRequestsWithTarget:self];
   
   [self addRandomPhysicsSphereObject];
   
   [self performSelector:
      @selector(scheduleAddRandomPhysicsSphereObject:) 
      withObject:nil afterDelay:1.0];
}


/////////////////////////////////////////////////////////////////
// 
- (IBAction)scheduleAddRandomPhysicsBoxObject:(id)dummy
{
   [[self class] cancelPreviousPerformRequestsWithTarget:self];
   
   [self addRandomPhysicsBoxObject];
   
   [self performSelector:
      @selector(scheduleAddRandomPhysicsBoxObject:) 
      withObject:nil afterDelay:1.0];
}


/////////////////////////////////////////////////////////////////
// 
- (IBAction)removeRegistedPhysicsObjects:(id)dummy
{
   PAppDelegate *appDelegate = 
      [[UIApplication sharedApplication] delegate];
   
   // Remove box objects that have fallen out of view
   for(PPhysicsObject *currentObject in [self.boxPhysicsObjects copy])
   {
      [appDelegate physicsUnregisterObject:currentObject];
      [self.boxPhysicsObjects removeObject:currentObject];
   }

   // Remove sphere objects that have fallen out of view
   for(PPhysicsObject *currentObject in [self.spherePhysicsObjects copy])
   {
      [appDelegate physicsUnregisterObject:currentObject];
      [self.spherePhysicsObjects removeObject:currentObject];
   }
}


#pragma mark - Motion and gestures

- (BOOL)canBecomeFirstResponder {
    return YES;
}


/////////////////////////////////////////////////////////////////
// 
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   [self removeRegistedPhysicsObjects:nil];
}

@end
