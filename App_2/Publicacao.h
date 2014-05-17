//
//  Publicacao.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Publicacao : NSObject

@property (nonatomic,retain) NSMutableArray* publication;

-(void) savePublication;
-(void) checkPublication;
-(NSString*) getPath;
-(void) addAutor:(NSString*) nome;
-(void) addPublicacao:(NSMutableArray*) pb;
+(id)   sharedPublicacao;

@end
