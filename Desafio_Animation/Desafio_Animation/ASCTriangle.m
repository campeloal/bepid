//
//  ASCTriangle.m
//  Desafio_Animation
//
//  Created by Alex De Souza Campelo Lima on 10/21/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCTriangle.h"

@implementation ASCTriangle

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
    if (_isLeft)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
        CGContextClosePath(ctx);
        
        CGContextSetRGBFillColor(ctx, _r, _g, _b, 1);
        CGContextFillPath(ctx);
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
        CGContextClosePath(ctx);
        
        CGContextSetRGBFillColor(ctx, _r, _g, _b, 1);
        CGContextFillPath(ctx);
    }
}


@end
