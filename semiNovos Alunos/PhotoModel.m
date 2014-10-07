//
//  PhotoModel.m
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/7/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "PhotoModel.h"
#import "AppDelegate.h"
#import "Photo.h"

@interface PhotoModel()

@property (nonatomic) NSMutableArray *privatePhotos;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation PhotoModel


+ (instancetype)sharedModel
{
    static PhotoModel *sharedModel = nil;
    
    if (!sharedModel) {
        sharedModel = [[self alloc] initPrivate];
    }
    
    return sharedModel;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        _context = appDelegate.managedObjectContext;
        
        _privatePhotos = [[NSMutableArray alloc] init];
        
        [self loadAllPhotos];
    }
    return self;
}

- (void)loadAllPhotos
{
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    request.entity = entity;
    
    NSError *error;
    
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    _privatePhotos = [[NSMutableArray alloc] initWithArray:result];
    
}

-(void) addPhotos:(NSArray *)objects
{
    [self.privatePhotos addObjectsFromArray:objects];
}

-(Photo*) createPhoto
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.context];
    
    [_privatePhotos addObject:photo];
    return photo;
}

@end
