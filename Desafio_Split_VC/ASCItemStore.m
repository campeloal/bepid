//
//  ASCItemStore.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCItemStore.h"

@interface ASCItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ASCItemStore

-(NSArray *) allItems
{
    return [NSArray arrayWithArray:self.privateItems];
}

-(ASCItem*) createItem
{
    ASCItem* newItem = [ASCItem randomItem];
    
    if (!_privateItems) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    [_privateItems addObject:newItem];
    return newItem;
}

+(instancetype) sharedStore
{
    static ASCItemStore *itemStore = nil;
    @synchronized(self) {
        if (itemStore == nil)
        {
            itemStore = [[self alloc] init];
            
        }
    }
    return itemStore;
}

-(void) removeItemAtIndex:(int)index
{
    [_privateItems removeObjectAtIndex:index];
}

-(void) addItem: (ASCItem*) newItem AtIndex:(int)index
{
    [_privateItems insertObject:newItem atIndex:index];
}

@end
