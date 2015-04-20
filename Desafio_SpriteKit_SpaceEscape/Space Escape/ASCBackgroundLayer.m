//
//  ASCBackgroundLayer.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCBackgroundLayer.h"

@implementation ASCBackgroundLayer

-(instancetype) initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self) {
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        
        self.layer1 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"StarLayer1" ofType:@"sks"]];
        
        self.layer2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"StarLayer2" ofType:@"sks"]];
        
        self.layer1.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
        self.layer2.position = self.layer1.position;
        
        [self addChild:self.layer1];
        [self addChild:self.layer2];
    }
    
    return self;
}

@end
