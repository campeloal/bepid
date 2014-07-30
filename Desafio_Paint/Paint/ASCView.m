//
//  ASCView.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCView.h"
#import "ASCShape.h"
#define NUMBER_PROPERTIES 10

@interface ASCView()

@property (nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) NSMutableDictionary *circlesInProgress;

@end

@implementation ASCView
{
    CGPoint fisrtTouchPoint, secondTouchPoint;
    BOOL drawCircle, touchedOnce;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _linesInProgress = [[NSMutableDictionary alloc] init];
        _circlesInProgress = [[NSMutableDictionary alloc] init];
        
        [self readFile];
        self.backgroundColor = [UIColor lightGrayColor];
        self.multipleTouchEnabled = YES;
        drawCircle = NO;
        touchedOnce = NO;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    for (ASCShape *line in self.finishedShapes) {
        
        [[self changeColor:line] set];
       
        if(line.isCircle)
        {
            [self drawCircleInRec:line.rect];
        }
        else
        {
            [line stroke];
        }
    }
    
    for(NSValue *key in self.linesInProgress)
    {
        ASCShape *line = self.linesInProgress[key];
        [[self changeColor:line] set];
        [line stroke];
    }
   // NSLog(@"circles in progress %d", [self.circlesInProgress count]);
    for(NSValue *key in self.circlesInProgress)
    {
        ASCShape *circle = self.circlesInProgress[key];
        [self drawCircleInRec:circle.rect];
    }
    
}

-(void) drawCircleInRec: (CGRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextStrokeEllipseInRect(ctx, rect);
    CGContextFillPath(ctx);
}

-(UIColor*) changeColor: (ASCShape*) line
{
    return [UIColor colorWithHue:fabs(line.angle/360) saturation:1.0 brightness:1.0 alpha:1.0];
}

-(CGRect) calculateCircle
{
    
    float dy = secondTouchPoint.y - fisrtTouchPoint.y;
    float dx = secondTouchPoint.x - fisrtTouchPoint.x;
    
    float hip = sqrtf(dx*dx + dy*dy);
    
    CGPoint finalPoint = [self getLessCoordinateX1:fisrtTouchPoint.x X2:secondTouchPoint.x Y1:fisrtTouchPoint.y Y2:secondTouchPoint.y];
    
    return [self checkPointsPosition:fisrtTouchPoint Point2:secondTouchPoint Final:finalPoint Radius:hip/2];
}

-(CGRect) checkPointsPosition: (CGPoint) point1 Point2: (CGPoint) point2 Final: (CGPoint) finalPoint Radius: (float) radius
{
    //vertical: x: x - radius y: nothing
    if(fabs(point1.x - point2.x) < radius)
    {
        return CGRectMake(finalPoint.x - radius,finalPoint.y, radius*2, radius*2);
    }
    //horizontal x : nothing y: y - radius
    else if(fabs(point1.y - point2.y) < radius)
    {
        return CGRectMake(finalPoint.x,finalPoint.y - radius, radius*2, radius*2);
    }
    
    //diagonal x: nothing y: nothing
    return CGRectMake(finalPoint.x, finalPoint.y, radius*2, radius*2);
}

-(CGPoint) getLessCoordinateX1: (float) x1 X2: (float) x2
Y1: (float) y1 Y2: (float) y2
{
    int finalX, finalY;
    
    if(x1 < x2)
    {
        finalX = x1;
    }
    else
    {
        finalX = x2;
    }
    
    if(y1 < y2)
    {
        finalY = y1;
    }
    else
    {
        finalY = y2;
    }
    return CGPointMake(finalX, finalY);
}

-(CGFloat) getAngle: (CGPoint) a : (CGPoint) b
{
    int x = a.x;
    int y = a.y;
    
    float dx = b.x - x;
    float dy = b.y - y;
    CGFloat radians = atan2f(dy, dx);
    CGFloat degrees = radians*180/3.14;
    return degrees;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchedOnce)
    {
        for(UITouch *t in touches)
        {
            secondTouchPoint = [t locationInView:self];
            //circleKey = [NSValue valueWithNonretainedObject:t];
            ASCShape *circle = [[ASCShape alloc] init];
            circle.rect = [self calculateCircle];
            circle.isCircle = YES;
            [self.circlesInProgress setObject:circle forKey:[NSValue valueWithNonretainedObject:t]];
            //[self.circlesInProgress setObject:circle forKey:lineKey];
        }
        drawCircle = YES;
        touchedOnce = NO;
        //remove old line point
        [self.linesInProgress removeAllObjects];
       
        
    }
    else
    {
        for(UITouch *t in touches)
        {
            CGPoint location = [t locationInView:self];
            fisrtTouchPoint = [t locationInView:self];
            ASCShape *line = [[ASCShape alloc] init];
            line.begin = location;
            line.end = location;
        
            [self.linesInProgress setObject:line forKey:[NSValue valueWithNonretainedObject:t]];
        }
        touchedOnce = YES;
    
    }
     [self setNeedsDisplay];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!drawCircle)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            CGPoint location = [t locationInView:self];
            ASCShape *line = self.linesInProgress[key];
            line.end = location;
        
            line.angle = [self getAngle:line.begin :line.end];
        
        }
            [self setNeedsDisplay];
    }
    else
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            [self discoverFirstSecondPoints:t];
            ASCShape *circle = self.circlesInProgress[key];
            if (circle) {
                circle.rect = [self calculateCircle];
            }
        }
        
        [self setNeedsDisplay];
    }
    
}

-(void) discoverFirstSecondPoints: (UITouch*) t
{
    CGPoint tempPoint = [t locationInView:self];
    if(fabs(tempPoint.x - fisrtTouchPoint.x) > fabs(tempPoint.x - secondTouchPoint.x))
    {
        fisrtTouchPoint = tempPoint;
    }
    else
    {
        secondTouchPoint = tempPoint;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    if((!drawCircle) && touchedOnce)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            ASCShape *line = self.linesInProgress[key];
            line.isCircle = NO;
            [self.finishedShapes addObject:line];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.begin.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.begin.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.end.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.end.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.angle]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.origin.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.origin.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.size.width]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.size.height]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%d",line.isCircle]];
            
        
            [self.linesInProgress removeObjectForKey:key];
        }
        
        
    }
    if(drawCircle)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            ASCShape *circle = self.circlesInProgress[key];
            
            if(circle)
            {
                [self.finishedShapes addObject: circle];
                NSLog(@"entrei");
            }
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.begin.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.begin.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.end.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.end.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.angle]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.rect.origin.x]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.rect.origin.y]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.rect.size.width]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%f",circle.rect.size.height]];
            [self.shapesProperties addObject: [NSString stringWithFormat:@"%d",circle.isCircle]];
            
            [self.circlesInProgress removeObjectForKey:key];
        }
    }
    [self setNeedsDisplay];
    drawCircle = NO;
    touchedOnce = NO;
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!drawCircle)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            [self.linesInProgress removeObjectForKey:key];
        }
            [self setNeedsDisplay];
    }
}

-(void) readFile
{
    _shapesProperties = [[NSMutableArray alloc] initWithContentsOfFile:[self getPath]];
    
    if (!_finishedShapes) {
        _finishedShapes = [[NSMutableArray alloc]init];
        
        
        int numberOfLines = [_shapesProperties count]/NUMBER_PROPERTIES;
        for(int i = 0; i < numberOfLines; i++) {
            ASCShape *line = [[ASCShape alloc] init];
            int x = [_shapesProperties[i*NUMBER_PROPERTIES] floatValue];
            int y = [_shapesProperties[i*NUMBER_PROPERTIES + 1] floatValue];
            line.begin = CGPointMake(x, y);
            x = [_shapesProperties[i*NUMBER_PROPERTIES + 2] floatValue];
            y = [_shapesProperties[i*NUMBER_PROPERTIES + 3] floatValue];
            
            line.end = CGPointMake(x, y);
            line.angle = [_shapesProperties[i*NUMBER_PROPERTIES + 4] floatValue];
            
            CGRect rect = CGRectMake([_shapesProperties[i*NUMBER_PROPERTIES + 5] floatValue], [_shapesProperties[i*NUMBER_PROPERTIES + 6] floatValue], [_shapesProperties[i*NUMBER_PROPERTIES + 7] floatValue], [_shapesProperties[i*NUMBER_PROPERTIES + 8] floatValue]);
            
            //NSLog(@"rect read x: %f y: %f width: %f",rect.origin.x,rect.origin.y,rect.size.width);
            
            line.rect = rect;
            line.isCircle = [_shapesProperties[i*NUMBER_PROPERTIES + 9] intValue];
            
            [_finishedShapes addObject:line];
        }
    }
    
    
    if(!_shapesProperties)
    {
        _shapesProperties = [[NSMutableArray alloc]init];
    }
}

-(NSString*) getPath
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"paint.plist"];
}

@end
