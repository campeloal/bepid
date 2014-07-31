//
//  ASCView.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCView.h"
#define NUMBER_PROPERTIES 10

@interface ASCView()

@property (nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) NSMutableDictionary *circlesInProgress;

@end

@implementation ASCView
{
    CGPoint fisrtTouchPoint, secondTouchPoint;
    CGPoint pointFirstPosition,begSelPosition, endSelPosition;
    BOOL drawCircle, touchedOnce,isFirstT, shouldAllowPan;
    UISlider* slider;
    float thickness,_radius;
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
        isFirstT = YES;
        thickness = 10;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delaysTouchesBegan = YES;
        [tap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:tap];

        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longpress.minimumPressDuration = 0.2;
        longpress.delegate = self;
        [self addGestureRecognizer:longpress];

        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        [swipeUp setDelaysTouchesBegan:YES];
        [swipeUp setNumberOfTouchesRequired:3];
        [self addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [swipeDown setDelaysTouchesBegan:YES];
        [swipeDown setNumberOfTouchesRequired:3];
        [self addGestureRecognizer:swipeDown];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

- (void)swipeDown:(UISwipeGestureRecognizer *)recognizer {
    
    [slider removeFromSuperview];
}

- (void)swipeUp:(UISwipeGestureRecognizer *)recognizer {
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.8, 300, 20)];
    [slider addTarget:self action:@selector(sliderValueChanged:)forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 2;
    slider.maximumValue = 15;
    slider.value = thickness;
    [self addSubview:slider];

}

-(void) sliderValueChanged: (UISlider*) s
{
    thickness = s.value;
    [self setNeedsDisplay];
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

- (ASCShape*) lineAtPoint: (CGPoint) p
{
    for (ASCShape *s in self.finishedShapes) {
        if ([s havePoint:p]) {
            return  s;
        }
    }
    return nil;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && ! shouldAllowPan) {
        return NO;
    }
    return YES;
}

-(void) panHandler: (UIGestureRecognizer*) gesture
{
    
    if(shouldAllowPan)
    {
        CGPoint pointCurPosition = [gesture locationInView:self];
       
        CGPoint distanceFinger = CGPointMake(pointCurPosition.x - pointFirstPosition.x, pointCurPosition.y - pointFirstPosition.y);
    
        
        self.selectedShape.begin = CGPointMake(begSelPosition.x + distanceFinger.x, begSelPosition.y + distanceFinger.y);
        self.selectedShape.end = CGPointMake(endSelPosition.x + distanceFinger.x, endSelPosition.y + distanceFinger.y);
        
        
        [self setNeedsDisplay];
    }

}

-(void) longPress: (UIGestureRecognizer*) gesture
{
    if(UIGestureRecognizerStateBegan == gesture.state) {
        shouldAllowPan = NO;
        pointFirstPosition = [gesture locationInView:self];
        
        self.selectedShape = [self lineAtPoint:pointFirstPosition];
        begSelPosition = CGPointMake(self.selectedShape.begin.x, self.selectedShape.begin.y);
        endSelPosition = CGPointMake(self.selectedShape.end.x, self.selectedShape.end.y);
        [self setNeedsDisplay];
    }
    
    if(UIGestureRecognizerStateChanged == gesture.state) {
        shouldAllowPan = YES;
    }
    
    if(UIGestureRecognizerStateEnded == gesture.state) {
        shouldAllowPan = NO;
    }

}

-(void) tap:(UIGestureRecognizer*) gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    self.selectedShape = [self lineAtPoint:point];
    
    if(self.selectedShape)
    {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        
        [menu setMenuVisible:YES animated:YES];
        
    }
    else
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

-(void) deleteLine:(id) sender
{
    [self.finishedShapes removeObject:self.selectedShape];
    self.selectedShape = nil;
    [self setNeedsDisplay];
}

-(void) doubleTap:(UIGestureRecognizer*) gestureRecognizer
{
    [self.linesInProgress removeAllObjects];
    [self.circlesInProgress removeAllObjects];
    [self.finishedShapes removeAllObjects];
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    for (ASCShape *line in self.finishedShapes) {
        
        [[self changeColor:line] set];
        line.thickness = thickness;
    
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
   
    for(NSValue *key in self.circlesInProgress)
    {
        ASCShape *circle = self.circlesInProgress[key];
        [self drawCircleInRec:circle.rect];
    }
    
    if(self.selectedShape)
    {
        [[UIColor greenColor] set];
        [self.selectedShape stroke];
    }
    
}

-(void) drawCircleInRec: (CGRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, thickness);
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
    _radius = hip/2;
    
    CGPoint finalPoint = [self getLessCoordinateX1:fisrtTouchPoint.x X2:secondTouchPoint.x Y1:fisrtTouchPoint.y Y2:secondTouchPoint.y];
    
    return [self checkPointsPosition:fisrtTouchPoint Point2:secondTouchPoint Final:finalPoint Radius:hip/2];
}

-(CGPoint) calculateCenterPoint: (CGPoint) point1 Point2: (CGPoint) point2
Radius: (float) radius
{
    //vertical: x: x - radius y: nothing
    if(fabs(point1.x - point2.x) < radius)
    {
        CGPoint refPoint = [self getLessCoordinateX1:point1.x X2:point2.x Y1:point1.y Y2:point2.y];
        return CGPointMake(refPoint.x, refPoint.y + radius);
    }
    //horizontal x : nothing y: y - radius
    else if(fabs(point1.y - point2.y) < radius)
    {
        CGPoint refPoint = [self getLessCoordinateX1:point1.x X2:point2.x Y1:point1.y Y2:point2.y];
        return CGPointMake(refPoint.x + radius, refPoint.y);
    }
    //diagonal
    else
    {
        CGPoint refPoint = [self getLessCoordinateX1:point1.x X2:point2.x Y1:point1.y Y2:point2.y];
        return CGPointMake(refPoint.x + radius, refPoint.y + radius);
    }
    
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
    NSValue *firstKey, *secondKey;
    
    if([touches count] == 2)
    {
        ASCShape *circle = [[ASCShape alloc] init];
        for(UITouch *t in touches)
        {
            if(isFirstT)
            {
                fisrtTouchPoint = [t locationInView:self];
                isFirstT = NO;
                firstKey = [NSValue valueWithNonretainedObject:t];
            }
            else
            {
                secondTouchPoint = [t locationInView:self];
                circle.rect = [self calculateCircle];
                circle.isCircle = YES;
                secondKey = [NSValue valueWithNonretainedObject:t];
                isFirstT = YES;
            }
        }
        
        [self.circlesInProgress setObject:circle forKey: firstKey];
        [self.circlesInProgress setObject:circle forKey: secondKey];
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
        NSValue *key;
        ASCShape *circle;
        for(UITouch *t in touches)
        {
            key = [NSValue valueWithNonretainedObject:t];
            [self discoverFirstSecondPoints:t];
            circle = self.circlesInProgress[key];
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
        
        touchedOnce = NO;
    }
    if(drawCircle)
    {
        int i = 0;
        for(UITouch *t in touches)
        {
            if(i == 0)
            {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            ASCShape *circle = self.circlesInProgress[key];
            
            if(circle)
            {
                [self.finishedShapes addObject: circle];
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
            i++;
            }
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
