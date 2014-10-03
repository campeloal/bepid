//
//  Car.h
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/3/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Client;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * manufacteredYear;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * modelYear;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) Client *owner;

@end
