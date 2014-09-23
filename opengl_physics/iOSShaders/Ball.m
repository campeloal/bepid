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
        
        GLfloat *vertices = [_render getVertices];
        int numberVertices = [_render numberPositionVertices];
        
        _physhics = [[PObject alloc] initWithName:"ball" mass:10.0 convex:NO tag: ballTag vertices: vertices vertexCount: numberVertices];
        
    }
    
    return self;
}

@end
