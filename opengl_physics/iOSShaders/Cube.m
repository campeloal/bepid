//
//  Cube.m
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/26/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Cube.h"
#import "cubeCoordinates.h"

@implementation Cube

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self setVb:cubeVertexBuffer];
        [self setVertCoordinates:cubeVertCoordinates];
        [self setNumberIndices:cubeNumberIndices];
        [self setBufferSize:cubeBufferSize];
        [self setVertSize:cubeVertSize];
        [self createObj:@"cube" Shader:@"gouraud"];
        
    }
    
    return self;
}

@end
