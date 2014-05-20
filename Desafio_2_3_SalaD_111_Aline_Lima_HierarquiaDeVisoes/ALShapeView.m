//
//  ALShapeView.m
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALShapeView.h"

@implementation ALShapeView

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
//    if([_shapes count] > 0)
//    {
//        for(int i = 0; i < [_shapes count]; i++)
//        {
//            NSLog(@" ENTREI PORRA");
//            CGContextRef context = UIGraphicsGetCurrentContext();
//            CGContextSetLineWidth(context, 4.0);
//            CGContextSetStrokeColorWithColor(context, _color.CGColor);
//            CGContextAddEllipseInRect(context, [[_shapes objectAtIndex:i] CGRectValue]);
//            CGContextStrokePath(context);
//        }
//    }
    
    if(_isRect == 1)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect rectangle = CGRectMake(_x,_y,_width,_height);
        CGContextSetFillColorWithColor(context, _color.CGColor);
        CGContextFillRect(context, rectangle);
    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 4.0);
        CGContextSetStrokeColorWithColor(context, _color.CGColor);
        CGRect ellipse = CGRectMake(_x, _y, _width, _height);
        CGContextAddEllipseInRect(context, ellipse);
        CGContextStrokePath(context);
    }
}


@end
