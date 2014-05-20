//
//  Shape.h
//  Desafio_Draw
//
//  Created by Alex on 5/19/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject

@property (nonatomic, retain) UIColor *color;
@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) BOOL isRect;

@end
