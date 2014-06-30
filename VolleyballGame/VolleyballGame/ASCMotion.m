//
//  ASCMotion.m
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCMotion.h"
#import <CoreMotion/CoreMotion.h>

@implementation ASCMotion
{
    CMMotionManager *motionManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        motionManager = [[CMMotionManager alloc] init];
        motionManager.accelerometerUpdateInterval = .1;
        
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                [self outputAccelertionData:accelerometerData.acceleration];
                                                if(error){
                                                    
                                                    NSLog(@"%@", error);
                                                }
                                            }];
        
        _singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleSingleTap:)];
        [_singleTapGestureRecognizer setNumberOfTapsRequired:1];

    }
    return self;
}


-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    [_delegate updatePositionX: acceleration.x Y:acceleration.y ];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [_delegate jump];
}




@end
