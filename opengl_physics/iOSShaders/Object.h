//
//  3DObject.h
//  readObj
//
//  Created by Alex De Souza Campelo Lima on 5/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TRIANGLES 12
#define VERTICES_PER_TRIANGLE 3
#define VERTEX_COORDINATES 3
#define NORMALS_COORDINATES 3
#define TEXTURE_COORDINATES 2
#define NUMBER_POLYGONS  TRIANGLES * (VERTEX_COORDINATES + NORMALS_COORDINATES) * VERTICES_PER_TRIANGLE

@interface Object : NSObject

@property (nonatomic,retain) NSMutableArray *verticesToAddBuffer;
@property (nonatomic) int totalNumberVertices;
@property (nonatomic) int totalNumberPositionVertices;

-(void) loadObj:(NSString*) name;
-(GLfloat*) generateArray;
-(GLfloat*) generateOnlyVertices;


@end
