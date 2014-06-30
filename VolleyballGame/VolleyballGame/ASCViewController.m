//
//  ASCViewController.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/1/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCMyScene.h"
#define SPEED 200
#define POSITION_DELTA 0.001

@implementation ASCViewController
{
    ASCMotion*motion;
    ASCMyScene *scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillLayoutSubviews
{
    motion = [[ASCMotion alloc] init];
    motion.delegate = self;
    
    [self.view addGestureRecognizer:[motion singleTapGestureRecognizer]];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    
    scene = [ASCMyScene sceneWithSize:skView.bounds.size];
    
    //scene.currentLocation = CGPointMake(self.view.window.center.x, self.view.window.center.y);
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) updatePositionX:(double)accX Y:(double)accY
{
//        if(fabs(accX) > POSITION_DELTA)
//        {
//            scene.currentLocation = CGPointMake(scene.currentLocation.x + accX*SPEED,scene.currentLocation.y + accY*SPEED);
//        }
    
        if(fabs(accY) > POSITION_DELTA)
        {
            scene.currentLocation = CGPointMake(scene.currentLocation.x,scene.currentLocation.y+ accY*SPEED);
        }

}

-(void) jump
{
    [scene jump];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
