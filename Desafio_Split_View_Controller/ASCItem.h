//
//  ASCItem.h
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int value;
@property (nonatomic,readonly) NSDate *dateCreated;

-(instancetype) initWithItemName: (NSString*) name
                           value: (int) value
                    serialNumber: (NSString*) sNumber;

-(instancetype) initWithItemName: (NSString*) name;

+(instancetype) randomItem;

-(NSString*) getItemName;
-(NSString*) getSerialNumber;
-(int) getValue;


@end
