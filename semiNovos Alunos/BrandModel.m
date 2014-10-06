//
//  BarndModel.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/29/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "BrandModel.h"
#import "AppDelegate.h"
#import "Brand.h"

@interface BrandModel ()

@property (nonatomic) NSMutableArray *privateBrands;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
@implementation BrandModel

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BrandModel sharedModel]"
                                 userInfo:nil];
    return nil;
}

+ (instancetype)sharedModel
{
    static BrandModel *sharedModel = nil;
    
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
        
        [self loadAllBrands];
    }
    return self;
}

- (Brand *)createBrand
{
    Brand *brand = [NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:self.context];
    brand.brand = @"";
    
     [_privateBrands addObject:brand];
    
    return brand;
}

- (void)loadAllBrands
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    request.entity = entity;
    
    NSError *error;
    
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    _privateBrands = [[NSMutableArray alloc] initWithArray:result];
    
}

- (NSArray *)allBrands
{
    return [NSArray arrayWithArray:self.privateBrands];
}

@end
