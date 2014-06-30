//
//  ASCMotion.h
//  VolleyballGame
//
//  Created by Alex De Souza Campelo Lima on 7/2/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Motion

-(void) updatePositionX:(double) accX Y:(double) accY;
-(void) jump;

@end

@interface ASCMotion : NSObject

@property (nonatomic, assign) id delegate;
@property (nonatomic) UITapGestureRecognizer *singleTapGestureRecognizer;

@end
