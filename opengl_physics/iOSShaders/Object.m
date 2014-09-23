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
    int indexCoord;
    
}

static GLfloat finalVertices[NUMBER_POLYGONS];
static GLfloat onlyVertices[2800*VERTICES_PER_TRIANGLE*VERTEX_COORDINATES];

- (instancetype)init
{
    self = [super init];
    if (self) {
        vertices = [[NSMutableArray alloc] init];
        _verticesToAddBuffer = [[NSMutableArray alloc] init];
        normals = [[NSMutableArray alloc] init];
        textures = [[NSMutableArray alloc] init];
        hasTexture = NO;
        _totalNumberVertices = 0;
        indexCoord = 0;
    }
    
    return self;
}

-(void) loadObj:(NSString*) name
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:name
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
        NSMutableArray *mutFields = [[NSMutableArray alloc] initWithArray:fields];
        [mutFields removeObjectAtIndex:0];
        
        if([[fields objectAtIndex:0] isEqualToString: @"v"])
        {
            [vertices addObjectsFromArray: mutFields];
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"f"])
        {
            [self readFaces: line];
            
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"vt"])
        {
            [textures addObjectsFromArray: mutFields];
            if (hasTexture == NO) {
                hasTexture = YES;
            }
        }
        else if([[fields objectAtIndex:0] isEqualToString: @"vn"])
        {
            [normals addObjectsFromArray:mutFields];
        }
        
    }
    _totalNumberVertices = _totalNumberVertices*3;
    //NSLog(@"Buffer: %@", _verticesToAddBuffer);

}

-(void) readFaces: (NSString*) indices
{
    _totalNumberVertices++;
    
    if(hasTexture)
    {
        [self readFacesWithIndex:indices withDelimiter:@"/"];
    }
    else
    {
        [self readFacesWithIndex:indices withDelimiter:@"//"];
     
    }
    
    
}

-(void)  readFacesWithIndex: (NSString*) indices  withDelimiter: (NSString*) delimiter
{
    NSArray *indicesPerVertex = [indices componentsSeparatedByString:@" "];
    NSMutableArray *mutIndicesPerVertex = [[NSMutableArray alloc] initWithArray:indicesPerVertex];
    [mutIndicesPerVertex removeObjectAtIndex:0];
    
    
    for (NSString* index in mutIndicesPerVertex) 
    {
        NSArray *values = [index componentsSeparatedByString:delimiter];

        int verticeIndex = [values[0] intValue];
        int normalsIndex =  [values[1] intValue];
        
        int vertStartIndex = (verticeIndex * 3) -3;
        int normStartIndex = (normalsIndex * 3) - 3;
        
        NSNumber *vertice1 = [[NSNumber alloc] initWithFloat: [vertices[vertStartIndex] floatValue]];
        NSNumber *vertice2 = [[NSNumber alloc] initWithFloat: [vertices[vertStartIndex + 1] floatValue]];
        NSNumber *vertice3 = [[NSNumber alloc] initWithFloat: [vertices[vertStartIndex + 2] floatValue]];
        NSNumber *normal1 =  [[NSNumber alloc] initWithFloat: [normals[normStartIndex] floatValue]];
        NSNumber *normal2 =  [[NSNumber alloc] initWithFloat: [normals[normStartIndex + 1] floatValue]];
        NSNumber *normal3 =  [[NSNumber alloc] initWithFloat: [normals[normStartIndex + 2] floatValue]];
        
        NSMutableArray *allVertices = [[NSMutableArray alloc] init];
        NSMutableArray *allNormals = [[NSMutableArray alloc] init];
        
        [allVertices addObject:vertice1];
        [allVertices addObject:vertice2];
        [allVertices addObject:vertice3];
        [allNormals addObject:normal1];
        [allNormals addObject:normal2];
        [allNormals addObject:normal3];
        
        int numberCoordinates;
        
        if (hasTexture) {
            numberCoordinates = 8;
        }
        else
        {
            numberCoordinates = 6;
        }
        
        
        finalVertices[indexCoord*numberCoordinates] = [[allVertices objectAtIndex:0] floatValue];
        
        finalVertices[indexCoord*numberCoordinates + 1] = [[allVertices objectAtIndex:1] floatValue];
        
        finalVertices[indexCoord*numberCoordinates + 2] = [[allVertices objectAtIndex:2] floatValue];
        
        finalVertices[indexCoord*numberCoordinates + 3] = [[allNormals objectAtIndex:0] floatValue];
        
        finalVertices[indexCoord*numberCoordinates + 4] = [[allNormals objectAtIndex:1] floatValue];
        
        finalVertices[indexCoord*numberCoordinates + 5] = [[allNormals objectAtIndex:2] floatValue];
        
        onlyVertices[indexCoord*numberCoordinates] = [[allVertices objectAtIndex:0] floatValue];
        onlyVertices[indexCoord*numberCoordinates + 1] = [[allVertices objectAtIndex:1] floatValue];
        onlyVertices[indexCoord*numberCoordinates + 2] = [[allVertices objectAtIndex:2] floatValue];
    
        if(hasTexture)
        {
            int textureIndex = [values[2] intValue];
            int texStartIndex = (textureIndex * 2) - 2;
            
            NSNumber *texture1 = [[NSNumber alloc] initWithFloat: [textures[texStartIndex] floatValue]];
            NSNumber *texture2 = [[NSNumber alloc] initWithFloat: [textures[texStartIndex + 1] floatValue]];
            
            NSMutableArray *allTextures = [[NSMutableArray alloc] init];
            
            [allTextures addObject:texture1];
            [allTextures addObject:texture2];
            
            finalVertices[indexCoord*numberCoordinates + 6] = [[allNormals objectAtIndex:0] floatValue];
            finalVertices[indexCoord*numberCoordinates + 7] = [[allNormals objectAtIndex:1] floatValue];
        }
        _totalNumberPositionVertices = indexCoord*numberCoordinates + 2;
        indexCoord++;
    }
    
}

-(GLfloat*) generateOnlyVertices
{
    return onlyVertices;
}

-(GLfloat*) generateArray
{
    
    return finalVertices;
}

@end
