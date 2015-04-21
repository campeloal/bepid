//
//  ViewController.m
//  Facebook_Pop
//
//  Created by Alex De Souza Campelo Lima on 4/21/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ViewController.h"
#import <POP/POP.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *bounceView;
@property (weak, nonatomic) IBOutlet UIView *rotateView;
@property (weak, nonatomic) IBOutlet UIView *slideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self doScaleAnimation];
    
    [self doRotationAnimation];
    
    [self doSlideAnimation];
    
}

-(void) doScaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.springBounciness = 20.f;
    [self.bounceView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
}

-(void) doRotationAnimation
{
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.2;
    rotationAnimation.toValue = @(1.57);
    rotationAnimation.springBounciness = 10.f;
    rotationAnimation.springSpeed = 3;
    [self.rotateView.layer pop_addAnimation:rotationAnimation forKey:@"rotateAnim"];
    
}

-(void) doSlideAnimation
{
    POPDecayAnimation *slideAnim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    slideAnim.velocity = @(660.);
    slideAnim.toValue = @(40);
    [slideAnim setCompletionBlock:^(POPAnimation *anim,BOOL finished){
        
        [self doTransparencyAnimation];
        
    }];
    
    [self.slideView.layer pop_addAnimation:slideAnim forKey:@"slideAnim"];
    
}

-(void) doTransparencyAnimation
{
    
    POPBasicAnimation *transparencyAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    transparencyAnimation.toValue = @(0.0);
    [_slideView.layer pop_addAnimation:transparencyAnimation forKey:@"transpAnim"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
