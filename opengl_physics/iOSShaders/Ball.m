//
//  Ball.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/24/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Ball.h"
#define ballTag 0

@implementation Ball

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _render = [[RObject alloc] initWithObject:@"hand_2500" Shader:@"gouraud"];
        
    }
    
    return self;
}

@end
