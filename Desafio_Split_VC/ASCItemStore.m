//
//  ASCItemStore.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCItemStore.h"

@import CoreData;

@interface ASCItemStore()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) NSManagedObjectModel *model;
@property (nonatomic) int value;

@end

@implementation ASCItemStore

-(NSArray *) allItems
{
    return [NSArray arrayWithArray:self.privateItems];
}

-(ASCItem*) createItem
{
    ASCItem *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ASCItem" inManagedObjectContext:self.context];
    
    newItem.orderingValue = _value;
    
    if (!_privateItems) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    [newItem randomData];
    
    [_privateItems addObject:newItem];
    _value++;
    return newItem;
}

+(instancetype) sharedStore
{
    static ASCItemStore *itemStore = nil;
    @synchronized(self) {
        if (itemStore == nil)
        {
            itemStore = [[self alloc] initPrivate];
            
        }
    }
    return itemStore;
}

-(void) removeItemAtIndex:(int)index
{
    [_context deleteObject:_privateItems[index]];
    [_privateItems removeObjectAtIndex:index];
    [self saveChanges];
}

-(void) addItem: (ASCItem*) newItem AtIndex:(int)index
{
    [_privateItems insertObject:newItem atIndex:index];
    [self saveChanges];
}

-(void) moveItem: (ASCItem*) newItem AtIndex:(int)index FromIndex: (int) fromIndex
{
    [_context deleteObject:_privateItems[fromIndex]];
    [_privateItems removeObjectAtIndex:fromIndex];
    [_privateItems insertObject:newItem atIndex:index];
    [self saveChanges];
}

-(NSString*) itemArchivePath
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"database.bd"];
}

-(void) loadAllItems
{
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"ASCItem" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        
        request.sortDescriptors = @[sd];
        
        NSError *error;
        
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

-(instancetype) initPrivate
{
    self = [self init];
    
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        
        _value = 0;
        
        [self loadAllItems];
    }
    
    return self;
}

-(BOOL) saveChanges
{
    NSError *error;
    
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    return successful;
}

@end
