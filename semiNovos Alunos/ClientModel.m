//
//  ClientModel.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "ClientModel.h"
#import "AppDelegate.h"
#import "Client.h"

@interface ClientModel ()

@property (nonatomic) NSMutableArray *privateClients;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
@implementation ClientModel

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[ClientModel sharedModel]"
                                 userInfo:nil];
    return nil;
}

+ (instancetype)sharedModel
{
    static ClientModel *sharedModel = nil;
    
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
        
        [self loadAllClients];
    }
    return self;
}

- (Client *)createClient
{
    Client *client = [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:self.context];
    
    client.birthDate = nil;
    client.name = @"";
    client.photo = nil;
    client.thumbnail = nil;
    
     [_privateClients addObject:client];
    
    return client;
}

- (void)loadAllClients
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    request.entity = entity;
    request.resultType = NSDictionaryResultType;
    
    NSError *error;
    
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    _privateClients = [[NSMutableArray alloc] initWithArray:result];
    
}

- (NSArray *)allClients
{
    return [NSArray arrayWithArray:self.privateClients];
}

@end