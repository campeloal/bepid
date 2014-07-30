//
//  ASCView.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCView.h"
#import "ASCLine.h"
#define NUMBER_PROPERTIES 10

@interface ASCView()

@property (nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) NSMutableArray *circlesInProgress;

@end

@implementation ASCView
{
    CGPoint fisrtTouch, secondTouch;
    BOOL drawCircle, touched;
    ASCLine *currentCircle;
    NSValue *lineKey;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _linesInProgress = [[NSMutableDictionary alloc] init];
        _finishedCircles = [[NSMutableArray alloc] init];
        _circlesInProgress = [[NSMutableArray alloc] init];
        [self readFile];
        self.backgroundColor = [UIColor lightGrayColor];
        self.multipleTouchEnabled = YES;
        drawCircle = NO;
        touched = NO;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    for (ASCLine *line in self.finishedLines) {
        
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
    
    [self drawCircleInRec:currentCircle.rect];
    
    for(NSValue *key in self.linesInProgress)
    {
        ASCLine *line = self.linesInProgress[key];
        [[self changeColor:line] set];
        [line stroke];
    }
    
}

-(void) drawCircleInRec: (CGRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);
}

-(UIColor*) changeColor: (ASCLine*) line
{
    return [UIColor colorWithHue:fabs(line.angle/360) saturation:1.0 brightness:1.0 alpha:1.0];
}

-(CGRect) calculateCircle
{
    
    if(secondTouch.x < fisrtTouch.x)
    {
        CGPoint tempPoint = secondTouch;
        
        secondTouch = fisrtTouch;
        fisrtTouch = tempPoint;
    }
   
    float dy = secondTouch.y - fisrtTouch.y;
    float dx = secondTouch.x - fisrtTouch.x;
    
    float hip = sqrtf(dx*dx + dy*dy);
    
    return CGRectMake(fisrtTouch.x, fisrtTouch.y - hip/2, hip, hip);
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
    
    if(touched)
    {
        for(UITouch *t in touches)
        {
            secondTouch = [t locationInView:self];
        }
        drawCircle = YES;
        touched = NO;
        currentCircle = [[ASCLine alloc] init];
        currentCircle.rect = [self calculateCircle];
        currentCircle.isCircle = YES;
       
        [self.linesInProgress removeObjectForKey:lineKey];
        [self.circlesInProgress addObject:currentCircle];
        [self setNeedsDisplay];
        
    }
    else
    {
        for(UITouch *t in touches)
        {
            CGPoint location = [t locationInView:self];
            fisrtTouch = [t locationInView:self];
            ASCLine *line = [[ASCLine alloc] init];
            line.begin = location;
            line.end = location;
        
            lineKey = [NSValue valueWithNonretainedObject:t];
        
            [self.linesInProgress setObject:line forKey:lineKey];
        }
        
        touched = YES;
    [self setNeedsDisplay];
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!drawCircle)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            CGPoint location = [t locationInView:self];
            ASCLine *line = self.linesInProgress[key];
            line.end = location;
        
            line.angle = [self getAngle:line.begin :line.end];
        
        }
            [self setNeedsDisplay];
    }
    else
    {
        for(UITouch *t in touches)
        {
            CGPoint tempPoint = [t locationInView:self];
            if(fabs(tempPoint.x - fisrtTouch.x) > fabs(tempPoint.x - secondTouch.x))
            {
                fisrtTouch = tempPoint;
            }
            else
            {
                secondTouch = tempPoint;
            }
        }
        
        currentCircle.rect = [self calculateCircle];
        [self setNeedsDisplay];
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    if((!drawCircle) && touched)
    {
        for(UITouch *t in touches)
        {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            ASCLine *line = self.linesInProgress[key];
            line.isCircle = NO;
            [self.finishedLines addObject:line];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.begin.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.begin.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.end.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.end.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.angle]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.origin.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.origin.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.size.width]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",line.rect.size.height]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%d",line.isCircle]];
            
        
            [self.linesInProgress removeObjectForKey:key];
        }
        
        
    }
    if(drawCircle)
    {
            [_finishedLines addObject:currentCircle];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.begin.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.begin.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.end.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.end.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.angle]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.rect.origin.x]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.rect.origin.y]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.rect.size.width]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%f",currentCircle.rect.size.height]];
            [self.linesProperties addObject: [NSString stringWithFormat:@"%d",currentCircle.isCircle]];
        
    }
    [self setNeedsDisplay];
    drawCircle = NO;
    touched = NO;
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
    _linesProperties = [[NSMutableArray alloc] initWithContentsOfFile:[self getPath]];
    
    if (!_finishedLines) {
        _finishedLines = [[NSMutableArray alloc]init];
        
        
        int numberOfLines = [_linesProperties count]/NUMBER_PROPERTIES;
        for(int i = 0; i < numberOfLines; i++) {
            ASCLine *line = [[ASCLine alloc] init];
            int x = [_linesProperties[i*NUMBER_PROPERTIES] floatValue];
            int y = [_linesProperties[i*NUMBER_PROPERTIES + 1] floatValue];
            line.begin = CGPointMake(x, y);
            x = [_linesProperties[i*NUMBER_PROPERTIES + 2] floatValue];
            y = [_linesProperties[i*NUMBER_PROPERTIES + 3] floatValue];
            
            line.end = CGPointMake(x, y);
            line.angle = [_linesProperties[i*NUMBER_PROPERTIES + 4] floatValue];
            
            CGRect rect = CGRectMake([_linesProperties[i*NUMBER_PROPERTIES + 5] floatValue], [_linesProperties[i*NUMBER_PROPERTIES + 6] floatValue], [_linesProperties[i*NUMBER_PROPERTIES + 7] floatValue], [_linesProperties[i*NUMBER_PROPERTIES + 8] floatValue]);
            
            //NSLog(@"rect read x: %f y: %f width: %f",rect.origin.x,rect.origin.y,rect.size.width);
            
            line.rect = rect;
            line.isCircle = [_linesProperties[i*NUMBER_PROPERTIES + 9] intValue];
            
            [_finishedLines addObject:line];
        }
    }
    
    
    if(!_linesProperties)
    {
        _linesProperties = [[NSMutableArray alloc]init];
    }
}

-(NSString*) getPath
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"paint.plist"];
}

@end
