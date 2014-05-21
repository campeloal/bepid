//
//  SouthKoreaView.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/21/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "SouthKoreaView.h"

@implementation SouthKoreaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect white = CGRectMake(0,0,280,230);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, white);
    
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect blueBall = CGRectMake(90, 90, 75, 70);
    CGContextAddEllipseInRect(context, blueBall);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(context, blueBall);
    
    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 88, 120);
    CGContextAddCurveToPoint(context, 140,150 , 100,80 , 167, 120);
    CGContextMoveToPoint(context, 167, 120);
    CGContextAddQuadCurveToPoint(context, 105, 50, 88, 120);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 167, 120);
    CGContextAddQuadCurveToPoint(context, 180, 100, 110, 85);
    
    CGContextFillPath(context);
    
  
}


@end
