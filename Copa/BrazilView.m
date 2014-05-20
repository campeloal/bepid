//
//  BrazilView.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BrazilView.h"

@implementation BrazilView

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
    CGRect green = CGRectMake(0,250,400,300);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.263 green:0.42 blue:0.286 alpha:1.0].CGColor);
    CGContextFillRect(context, green);
    
    context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 150, 260);
    CGContextAddLineToPoint(context, 310, 350);
    CGContextAddLineToPoint(context, 150, 450);
    CGContextAddLineToPoint(context, 10, 350);
    CGContextAddLineToPoint(context, 150, 260);
    CGContextSetFillColorWithColor(context,
                                   [UIColor yellowColor].CGColor);
    CGContextFillPath(context);
    
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect ball = CGRectMake(87, 290, 130,130);
    CGContextAddEllipseInRect(context, ball);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(context, ball);
}


@end
