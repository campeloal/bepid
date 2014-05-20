//
//  ItalyView.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ItalyView.h"

@implementation ItalyView

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
    CGRect blue = CGRectMake(0,0,50,100);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, blue);
    
    context = UIGraphicsGetCurrentContext();
    CGRect white = CGRectMake(50,0,50,100);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, white);
    
    context = UIGraphicsGetCurrentContext();
    CGRect red = CGRectMake(100,0,50,100);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, red);
    
}


@end
