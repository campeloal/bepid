//
//  ASCItem.h
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/18/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ASCItem : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic) int  value;
@property (nonatomic) double orderingValue;

-(void) randomData;


@end
