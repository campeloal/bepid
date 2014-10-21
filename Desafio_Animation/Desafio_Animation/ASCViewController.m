//
//  ASCViewController.m
//  Desafio_Animation
//
//  Created by Alex De Souza Campelo Lima on 10/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCTriangle.h"
#import "ASCParallelogram.h"

@interface ASCViewController ()

@property (strong,nonatomic) UIView *redBox,*yellowBox;
@property (nonatomic) ASCTriangle *greenTriangle,*orangeTriangle,*blueTriangle1,*blueTriangle2;
@property (nonatomic) ASCTriangle *redSquare1, *redSquare2;
@property (nonatomic) ASCParallelogram *pinkParal;

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //YELLOW BOX
    _yellowBox = [[UIView alloc] initWithFrame:CGRectMake(152, 133, 50, 50)];
    _yellowBox.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_yellowBox];
    
    //RED BOX
    _redSquare1 = [[ASCTriangle alloc] initWithFrame:CGRectMake(110, 51, 50, 50)];
    _redSquare1.backgroundColor = [UIColor clearColor];
    _redSquare1.isLeft = YES;
    _redSquare1.r = 1;
    _redSquare1.g = 0;
    _redSquare1.b = 0;
    [self.view addSubview:_redSquare1];
    
    _redSquare2 = [[ASCTriangle alloc] initWithFrame:CGRectMake(110, 51, 50, 50)];
    _redSquare2.backgroundColor = [UIColor clearColor];
    _redSquare2.isLeft = NO;
    _redSquare2.r = 1;
    _redSquare2.g = 0;
    _redSquare2.b = 0;
    [self.view addSubview:_redSquare2];
    
    //GREEN TRIANGLE
    _greenTriangle = [[ASCTriangle alloc] initWithFrame:CGRectMake(152, 50, 50, 50)];
    _greenTriangle.isLeft = NO;
    _greenTriangle.r = 0;
    _greenTriangle.g = 1;
    _greenTriangle.b = 0;
    _greenTriangle.backgroundColor = [UIColor clearColor];
    [_greenTriangle setNeedsDisplay];
    [self.view addSubview:_greenTriangle];
    
    //ORANGE TRIANGLE
    _orangeTriangle = [[ASCTriangle alloc] initWithFrame:CGRectMake(70, 133, 50, 50)];
    _orangeTriangle.isLeft = YES;
    _orangeTriangle.r = 1;
    _orangeTriangle.g = 0.4;
    _orangeTriangle.b = 0;
    _orangeTriangle.backgroundColor = [UIColor clearColor];
    [_orangeTriangle setNeedsDisplay];
    [self.view addSubview:_orangeTriangle];
    
    //BLUE TRIANGLE 1
    _blueTriangle1 = [[ASCTriangle alloc] initWithFrame:CGRectMake(72, 10, 50, 50)];
    _blueTriangle1.isLeft = YES;
    _blueTriangle1.r = 0;
    _blueTriangle1.g = 0;
    _blueTriangle1.b = 1;
    _blueTriangle1.backgroundColor = [UIColor clearColor];
    [_blueTriangle1 setNeedsDisplay];
    [self.view addSubview:_blueTriangle1];
    
    //BLUE TRIANGLE 2
    _blueTriangle2 = [[ASCTriangle alloc] initWithFrame:CGRectMake(150, 10, 50, 50)];
    _blueTriangle2.isLeft = YES;
    _blueTriangle2.r = 0;
    _blueTriangle2.g = 0;
    _blueTriangle2.b = 1;
    _blueTriangle2.backgroundColor = [UIColor clearColor];
    [_blueTriangle2 setNeedsDisplay];
    [self.view addSubview:_blueTriangle2];
    
    //PINK PARALLELOGRAM
    _pinkParal = [[ASCParallelogram alloc] initWithFrame:CGRectMake(47, 60, 105, 109)];
    _pinkParal.backgroundColor = [UIColor clearColor];
    [_pinkParal setNeedsDisplay];
    [self.view addSubview:_pinkParal];
    
    [self formOriginalPosition];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(formLetterP)];
    singleTap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:singleTap];
    
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(formOriginalPosition)];
    [self.view addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(formLetterN)];
    doubleTap.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:doubleTap];
    
    
    
}


-(void) formLetterP
{
    [UIView animateWithDuration:2.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                     

                         CGAffineTransform translateTrans = CGAffineTransformMakeTranslation(5.0f,200.0f);
                         CGAffineTransform scaleTrans = CGAffineTransformMakeScale(1.62, 1.62);
                         _orangeTriangle.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.28, 1.28);
                         CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(18 * M_PI / 180);
                         _pinkParal.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _pinkParal.transform = CGAffineTransformConcat(_pinkParal.transform, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(2.3, 2.3);
                         rotateTrans = CGAffineTransformMakeRotation(45 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(44.0f,200.0f);
                         _blueTriangle1.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _blueTriangle1.transform = CGAffineTransformConcat(_blueTriangle1.transform, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(2.7, 2.7);
                         rotateTrans = CGAffineTransformMakeRotation(90 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(-48.0f,133.0f);
                         _blueTriangle2.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _blueTriangle2.transform = CGAffineTransformConcat(_blueTriangle2.transform, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.08, 1.08);
                         translateTrans = CGAffineTransformMakeTranslation(-8.0f,93.0f);
                         _yellowBox.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         
                         rotateTrans = CGAffineTransformMakeRotation(-45 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(-68.0f,94.0f);
                         scaleTrans = CGAffineTransformMakeScale(2.55, 2.55);
                         _greenTriangle.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         _greenTriangle.transform = CGAffineTransformConcat(_greenTriangle.transform, rotateTrans);
                         
                         
                         translateTrans = CGAffineTransformMakeTranslation(32.5f,52.0f);
                         scaleTrans = CGAffineTransformMakeScale(1.1, 1.1);
                         _redSquare2.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         
                         translateTrans = CGAffineTransformMakeTranslation(-68.0f,500.0f);
                         _redSquare1.transform = translateTrans;
                         
                         } completion:nil];
    
}

-(void) formLetterN
{
    [UIView animateWithDuration:2.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(-45 * M_PI / 180);
                         CGAffineTransform translateTrans = CGAffineTransformMakeTranslation(-200.0f,40.0f);
                         CGAffineTransform scaleTrans = CGAffineTransformMakeScale(2.55, 2.55);
                         _greenTriangle.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         _greenTriangle.transform = CGAffineTransformConcat(_greenTriangle.transform, rotateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.28, 1.28);
                         rotateTrans = CGAffineTransformMakeRotation(63 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(126.0f,80.0f);
                         _pinkParal.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _pinkParal.transform = CGAffineTransformConcat(_pinkParal.transform, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(5.6, 5.6);
                         translateTrans = CGAffineTransformMakeTranslation(-100.0f,70.0f);
                         rotateTrans = CGAffineTransformMakeRotation(-45 * M_PI / 180);
                         _yellowBox.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         _yellowBox.transform = CGAffineTransformConcat(translateTrans, rotateTrans);
                         
                         translateTrans = CGAffineTransformMakeTranslation(-142.0f,-185.0f);
                         rotateTrans = CGAffineTransformMakeRotation(225 * M_PI / 180);
                         scaleTrans = CGAffineTransformMakeScale(1.6, 1.6);
                         _orangeTriangle.transform = CGAffineTransformConcat(scaleTrans,translateTrans);
                         _orangeTriangle.transform = CGAffineTransformConcat(_orangeTriangle.transform, rotateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.46, 1.46);
                         rotateTrans = CGAffineTransformMakeRotation(45 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(20.0f,299.0f);
                         _blueTriangle1.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _blueTriangle1.transform = CGAffineTransformConcat(_blueTriangle1.transform, translateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.1, 1.1);
                         rotateTrans = CGAffineTransformMakeRotation(90 * M_PI / 180);
                         translateTrans = CGAffineTransformMakeTranslation(102.0f,100.0f);
                         _blueTriangle2.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _blueTriangle2.transform = CGAffineTransformConcat(_blueTriangle2.transform, translateTrans);
                         
                         translateTrans = CGAffineTransformMakeTranslation(80,-240.0f);
                         rotateTrans = CGAffineTransformMakeRotation(135 * M_PI / 180);
                         scaleTrans = CGAffineTransformMakeScale(2.3, 2.3);
                         _redSquare2.transform = CGAffineTransformConcat(scaleTrans, translateTrans);
                         _redSquare2.transform = CGAffineTransformConcat(_redSquare2.transform, rotateTrans);
                         } completion:nil];
}


-(void) formOriginalPosition
{
    [UIView animateWithDuration:2.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGAffineTransform scaleTrans = CGAffineTransformMakeScale(1.2, 1.2);
                         CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(-45 * M_PI / 180);
                         
                         _blueTriangle1.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         _blueTriangle2.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         
                         rotateTrans = CGAffineTransformMakeRotation(45 * M_PI / 180);
                         scaleTrans = CGAffineTransformMakeScale(1.15, 1.15);
                         _redSquare1.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         rotateTrans = CGAffineTransformMakeRotation(-45 * M_PI / 180);
                         _redSquare2.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         
                         scaleTrans = CGAffineTransformMakeScale(1.62, 1.62);
                         _greenTriangle.transform = scaleTrans;
                         
                         scaleTrans = CGAffineTransformMakeScale(1.66, 1.66);
                         _yellowBox.transform = scaleTrans;
                         
                         scaleTrans = CGAffineTransformMakeScale(1.62, 1.62);
                         _orangeTriangle.transform = scaleTrans;
                         
                         scaleTrans = CGAffineTransformMakeScale(1.28, 1.28);
                         rotateTrans = CGAffineTransformMakeRotation(18 * M_PI / 180);
                         _pinkParal.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
                         
                         } completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
