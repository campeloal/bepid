//
//  Photo.h
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/7/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Car;

@interface Photo : NSManagedObject

@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) Car *photoOwner;

@end
