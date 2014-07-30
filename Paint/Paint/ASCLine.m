//
//  ASCLine.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCLine.h"

@implementation ASCLine

-(void) stroke
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    [bp moveToPoint:self.begin];
    [bp addLineToPoint:self.end];
    [bp stroke];
}


@end
