//
//  ASCLine.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCShape.h"

@implementation ASCShape

- (instancetype)init
{
    self = [super init];
    if (self) {
        _thickness = 8.0;
    }
    return self;
}

-(void) stroke
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    
    bp.lineWidth = _thickness;
    bp.lineCapStyle = kCGLineCapRound;
    [bp moveToPoint:self.begin];
    [bp addLineToPoint:self.end];
    [bp stroke];
}

-(BOOL) havePoint:(CGPoint)point
{
    for (float t = 0.0; t < 1.0; t += 0.05) {
        float x = self.begin.x + t * (self.end.x - self.begin.x);
        float y = self.begin.y + t * (self.end.y - self.begin.y);
        
        if(hypot(x - point.x, y -point.y) < 20.0)
        {
            return YES;
        }
    }
    return NO;
}

@end
