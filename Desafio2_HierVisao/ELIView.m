//
//  ELIView.m
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ELIView.h"

@implementation ELIView

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
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect rectangle = CGRectMake(100, 100, 100, 100);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
}


@end
