//
//  ASCLine.h
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCShape : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect rect;
@property (nonatomic) CGPoint center;
@property (nonatomic) float thickness;
@property (nonatomic) BOOL isCircle;

-(void) stroke;
-(BOOL) havePoint: (CGPoint) point;
@end
