//
//  Ball.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/24/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Ball.h"
#import "ballCoordinates.h"

@implementation Ball

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setVb:ballVertexBuffer];
        [self setVertCoordinates:ballVertCoordinates];
        [self setNumberIndices:ballNumberIndices];
        [self setBufferSize:ballBufferSize];
        [self setVertSize:ballVertSize];
        [self createObj:@"ball_200" Shader:@"gouraud"];
        
    }
    
    return self;
}


@end
