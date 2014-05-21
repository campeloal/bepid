//
//  PrincipalView.m
//  UIScroll
//
//  Created by Alex De Souza Campelo Lima on 5/21/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "PrincipalView.h"

@implementation PrincipalView

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
/*- (void)drawRect:(CGRect)rect
{
    
}

*/


-(void) setup
{
    CGRect headerRect = CGRectMake(50,50,20,20);
    UILabel *header = [[UILabel alloc] initWithFrame:headerRect];
    header.text = @"Oi";
    [self addSubview:header];
    
    CGRect footerRect = CGRectMake(0,500,100,20);
    UILabel *footer = [[UILabel alloc] initWithFrame:footerRect];
    footer.text = @"Ola";
    [self addSubview:footer];
}
@end
