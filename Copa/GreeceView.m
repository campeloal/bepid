//
//  Greece.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "GreeceView.h"

@implementation GreeceView

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
    int height = 100;
    
    
    for(int i = 0; i < 5; i++)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect blueStrip = CGRectMake(0,height,400,20);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillRect(context, blueStrip);
        height +=20;
        
        if(i != 4)
        {
            context = UIGraphicsGetCurrentContext();
            CGRect whiteStrip = CGRectMake(0,height,400,20);
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextFillRect(context, whiteStrip);
            height +=20;
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect blueStrip = CGRectMake(0,100,100,100);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, blueStrip);
    
    context = UIGraphicsGetCurrentContext();
    CGRect vertStrip = CGRectMake(40,100,20,100);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, vertStrip);
    
    context = UIGraphicsGetCurrentContext();
    CGRect horStrip = CGRectMake(0,140,100,20);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, horStrip);

    
}


@end
