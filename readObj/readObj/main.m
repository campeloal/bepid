//
//  main.m
//  readObj
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *vertices = [[NSMutableArray alloc] init];
//        NSMutableArray *faces = [[NSMutableArray alloc] init];
//        NSMutableArray *normals = [[NSMutableArray alloc] init];
//        NSMutableArray *textures = [[NSMutableArray alloc] init];
//        NSMutableArray *indexes = [[NSMutableArray alloc] init];
        
        NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSError *error;
        NSString *objString = [[path objectAtIndex:0] stringByAppendingPathComponent:@"teste.obj"];
        NSString *objFile = [NSString stringWithContentsOfFile:objString encoding:NSUTF8StringEncoding error:&error];
        
        NSLog(@"%@", objString);
        if(error)
        {
            NSLog(@"Nao consegui abrir o arquivo");
        }
        
        for (NSString *line in [objFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]) {
            NSArray *fields = [line componentsSeparatedByString:@" "];
            
            if([[fields objectAtIndex:0] isEqualToString: @"v"])
            {
                [vertices addObjectsFromArray:fields];
            }
        }
        
        NSLog(@"%@", vertices);
    }
    return 0;
}

