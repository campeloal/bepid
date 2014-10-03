//
//  CarModel.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "CarModel.h"
#import "AppDelegate.h"
#import "Car.h"

@interface CarModel ()

@property (nonatomic) NSMutableArray *privateCars;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
@implementation CarModel

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[CarModel sharedModel]"
                                 userInfo:nil];
    return nil;
}

+ (instancetype)sharedModel
{
    static CarModel *sharedModel = nil;
    
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
        
        _privateCars = [[NSMutableArray alloc] init];
        
        [self loadAllCars];
    }
    return self;
}

- (Car *)createCar
{
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.context];
    car.model = @"";
    car.modelYear = @"";
    car.color = @"";
    car.manufacteredYear = @"";
    
    [_privateCars addObject:car];
    
    return car;
}

- (void)loadAllCars
{
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    request.entity = entity;
    request.resultType = NSDictionaryResultType;
   
    NSError *error;
    
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    _privateCars = [[NSMutableArray alloc] initWithArray:result];
    
    [self checkAvailableCars];
}

-(void) checkAvailableCars
{
    for (Car* car in _privateCars) {
        if (car.owner) {
            [_privateCars removeObject:car];
        }
    }
}

- (void)removeCars:(NSArray *)objects fromCoreData:(BOOL)remove
{
    [self.privateCars removeObjectsInArray:objects];
    
    if (remove) {
        for (NSManagedObject *obj in objects) {
            [self.context deleteObject:obj];
        }
    }
}

- (NSArray *)allCars
{
    return [NSArray arrayWithArray:self.privateCars];
}

@end
