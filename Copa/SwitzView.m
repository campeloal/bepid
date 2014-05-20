//
//  SwitzView.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "SwitzView.h"

@implementation SwitzView

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
    CGRect rectangle = CGRectMake(0,0,350,200);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, rectangle);
    
    context = UIGraphicsGetCurrentContext();
    CGRect vertStrip = CGRectMake(80,0,20,200);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, vertStrip);
    
    context = UIGraphicsGetCurrentContext();
    CGRect horStrip = CGRectMake(0,100,350,20);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, horStrip);
}


@end
