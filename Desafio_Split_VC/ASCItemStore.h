//
//  ASCItemStore.h
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCItem.h"

@interface ASCItemStore : NSObject

@property (nonatomic,readonly) NSArray* allItems;

+(instancetype) sharedStore;
-(ASCItem *) createItem;
-(void) removeItemAtIndex:(int) index;
-(void) addItem: (ASCItem*) newItem AtIndex:(int) index;

@end
