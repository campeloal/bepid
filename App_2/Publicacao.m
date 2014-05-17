//
//  Publicacao.m
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "Publicacao.h"

@implementation Publicacao

- (id)init
{
    self = [super init];
    if (self) {
        _publication = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) savePublication
{
    [_publication writeToFile: [self getPath] atomically:YES];
    [self checkPublication];
}

-(NSString*) getPath
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"publicacao.plist"];
}

-(void) checkPublication
{
    NSArray *files = [[NSArray alloc] initWithContentsOfFile: [self getPath]];
    if([files count] > 0)
    {
        NSLog(@"%@",files);
    }
    else
    {
        NSLog(@"Nao há registro armazenado.");
    }
}

-(void) addAutor:(NSString *)nome
{
    [_publication addObject:nome];
}

-(void) addPublicacao:(NSMutableArray*) pb
{
    [_publication addObjectsFromArray:pb];
}

+(id) sharedPublicacao
{
    static Publicacao *sharedPublicacao = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^ {
        sharedPublicacao = [[self alloc] init];
    });
    
    return sharedPublicacao;
}


@end
