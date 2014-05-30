//
//  PageView.m
//  Diario
//
//  Created by Alex De Souza Campelo Lima on 5/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "PageView.h"

@implementation PageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) writeText
{
    CGRect headerRect = CGRectMake(100,200,100,100);
    UILabel *header = [[UILabel alloc] initWithFrame:headerRect];
    header.text = @"Oi";
    [self addSubview:header];
    NSLog(@"oi");
}

@end
