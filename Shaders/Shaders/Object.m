//
//  3DObject.m
//  readObj
//
//  Created by Alex De Souza Campelo Lima on 5/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "Object.h"

@implementation Object
{
    NSMutableArray *vertices;
    NSMutableArray *normals;
    NSMutableArray *textures;
    BOOL hasTexture;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        vertices = [[NSMutableArray alloc] init];
        _verticesToAddBuffer = [[NSMutableArray alloc] init];
        normals = [[NSMutableArray alloc] init];
        textures = [[NSMutableArray alloc] init];
        hasTexture = NO;
    }
    return self;
}

-(void) loadObj
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"teste"
                                                     ofType:@"obj"];
    NSError *error;
    NSString *objString = [NSString stringWithContentsOfFile:path
                                                                        encoding:NSUTF8StringEncoding
                                                                           error:&error];
    
    NSLog(@"%@", objString);
    if(error)
    {
        NSLog(@"Nao consegui abrir o arquivo");
    }
    
    for (NSString *line in [objString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]) {
        NSArray *fields = [line componentsSeparatedByString:@" "];
        
        if([[fields objectAtIndex:0] isEqualToString: @"v"])
        {
            [vertices addObjectsFromArray: fields];
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"f"])
        {
            [self readFaces: line];
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"vt"])
        {
            [textures addObjectsFromArray: fields];
            if (hasTexture == NO) {
                hasTexture = YES;
            }
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"vn"])
        {
            [normals addObjectsFromArray:fields];
        }
        
    }
    
    NSLog(@"Buffer: %@", _verticesToAddBuffer);

}

-(void) readFaces: (NSString*) indices
{
    
    if(hasTexture)
    {
        [self readFacesWithIndex:indices withDelimiter:@"/"];
    }
    else
    {
        [self readFacesWithIndex:indices withDelimiter:@"//"];
     
    }
    
}

-(void) readFacesWithIndex: (NSString*) indices  withDelimiter: (NSString*) delimiter
{
    NSArray *indicesPerVertex = [indices componentsSeparatedByString:@" "];
    NSMutableArray *mutIndicesPerVertex = [[NSMutableArray alloc] initWithArray:indicesPerVertex];
    [mutIndicesPerVertex removeObjectAtIndex:0];
    
    for (NSString* index in mutIndicesPerVertex)
    {
        NSArray *values = [index componentsSeparatedByString:delimiter];
        
        if(hasTexture)
        {
            int verticeIndex = [values[0] intValue];
            int normalsIndex =  [values[1] intValue];
            int textureIndex = [values[2] intValue];
        
            NSNumber *vertice = [[NSNumber alloc] initWithFloat: [vertices[verticeIndex] floatValue]];
            NSNumber *normal =  [[NSNumber alloc] initWithFloat: [normals[normalsIndex] floatValue]];
            NSNumber *texture = [[NSNumber alloc] initWithFloat: [textures[textureIndex] floatValue]];
            
            [_verticesToAddBuffer addObject: vertice];
            [_verticesToAddBuffer addObject: normal];
            [_verticesToAddBuffer addObject: texture];
        }
        else
        {
            int verticeIndex = [values[0] intValue];
            int normalsIndex =  [values[1] intValue];
            
            
            
            NSNumber *vertice = [[NSNumber alloc] initWithFloat: [vertices[verticeIndex] floatValue]];
            NSNumber *normal =  [[NSNumber alloc] initWithFloat: [normals[normalsIndex] floatValue]];
            
            [_verticesToAddBuffer addObject: vertice];
            [_verticesToAddBuffer addObject: normal];
            
        }
        
    }
}


@end
