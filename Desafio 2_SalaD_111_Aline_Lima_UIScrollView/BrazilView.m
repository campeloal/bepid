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
    
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 8.0);
    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 89, 330);
    CGContextAddQuadCurveToPoint(context, 150, 300, 220, 360);
    CGContextStrokePath(context);
    
    context = UIGraphicsGetCurrentContext();
    
    [self createStar:context XCenter:100.0 YCenter:350.0 Radius:8];
    [self createStar:context XCenter:105.0 YCenter:365.0 Radius:8];
    [self createStar:context XCenter:110.0 YCenter:380.0 Radius:8];
    [self createStar:context XCenter:180.0 YCenter:320.0 Radius:8];
    [self createStar:context XCenter:140.0 YCenter:350.0 Radius:6];
    [self createStar:context XCenter:150.0 YCenter:370.0 Radius:6];
    [self createStar:context XCenter:175.0 YCenter:365.0 Radius:6];
    [self createStar:context XCenter:180.0 YCenter:350.0 Radius:6];
    [self createStar:context XCenter:200.0 YCenter:380.0 Radius:6];
}

-(void) createStar: (CGContextRef) context XCenter: (CGFloat) xCenter YCenter: (CGFloat) yCenter
            Radius: (float) r
{
    float flip = -1.0;
    
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    double theta = 2.0 * M_PI * (2.0 / 5.0); // 144 degrees
    
    CGContextMoveToPoint(context, xCenter, r*flip+yCenter);
    
    for (NSUInteger k=1; k<5; k++)
    {
        float x = r * sin(k * theta);
        float y = r * cos(k * theta);
        CGContextAddLineToPoint(context, x+xCenter, y*flip+yCenter);
    }
    xCenter += 150.0;
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
