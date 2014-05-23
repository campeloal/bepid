//
//  PaginaView.m
//  DesafioDiario
//
//  Created by Alex on 5/22/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "PaginaView.h"

@implementation PaginaView

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

-(void) writeText:(NSString *)text InFrame:(CGRect)frame
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
    textLabel.text = text;
    [self addSubview:textLabel];
}

-(void) writeTopic:(NSString *)text InFrame:(CGRect)frame
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
    textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    textLabel.text = text;
    [self addSubview:textLabel];
}

@end
