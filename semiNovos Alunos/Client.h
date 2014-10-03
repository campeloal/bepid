//
//  Client.h
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/3/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface Client : NSManagedObject

@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) NSSet *own;

-(void) setThumbnailFromImage:(UIImage*) image;

@end
