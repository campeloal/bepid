//
//  PhotoModel.h
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/7/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Photo;

@interface PhotoModel : NSObject

@property (nonatomic, readonly) NSArray *allPhotos;

+ (instancetype)sharedModel;
-(void) addPhotos:(NSArray *)objects;
-(Photo*) createPhoto;

@end
