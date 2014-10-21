//
//  ASCParallelogram.m
//  Desafio_Animation
//
//  Created by Alex De Souza Campelo Lima on 10/21/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCParallelogram.h"

@implementation ASCParallelogram

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
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMaxX(rect)*0.000005, CGRectGetMaxY(rect)*0.05);  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)*0.19, CGRectGetMaxY(rect)*0.63);  // middle left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)*0.94, CGRectGetMaxY(rect));  // bottom right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)*0.77, CGRectGetMidY(rect)*0.86);  // middle right
    CGContextClosePath(ctx);
    
    CGContextSetRGBFillColor(ctx, 1, 0.6, 0.9, 1);
    CGContextFillPath(ctx);
}


@end
