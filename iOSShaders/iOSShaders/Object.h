//
//  3DObject.h
//  readObj
//
//  Created by Alex De Souza Campelo Lima on 5/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object : NSObject

@property (nonatomic,retain) NSMutableArray *verticesToAddBuffer;
@property (nonatomic) int totalNumberVertices;

-(void) loadObj:(NSString*) name;



@end
