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
    for(Shape *shape in _shapes)
    {
        
    if([shape isRect] == 1)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect rectangle = CGRectMake([shape x],[shape y],[shape width],[shape height]);
        CGContextSetFillColorWithColor(context, [shape color].CGColor);
        CGContextFillRect(context, rectangle);
    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 4.0);
        CGContextSetStrokeColorWithColor(context, [shape color].CGColor);
        CGRect ellipse = CGRectMake([shape x], [shape y], [shape width], [shape height]);
        CGContextAddEllipseInRect(context, ellipse);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [shape color].CGColor);
        CGContextFillEllipseInRect(context, ellipse);
    }
    }
}


@end
