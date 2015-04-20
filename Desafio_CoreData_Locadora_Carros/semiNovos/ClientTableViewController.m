//
//  ClientTableViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "ClientTableViewController.h"
#import "ClientViewController.h"
#import "ClientModel.h"
#import "Client.h"
#import "CarModel.h"

@interface ClientTableViewController ()

@end

@implementation ClientTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"Clientes";
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ClientModel *clientModel = [ClientModel sharedModel];
    return [[clientModel allClients] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    ClientModel *clientModel = [ClientModel sharedModel];
    NSMutableArray *clients = [[NSMutableArray alloc] initWithArray:clientModel.allClients];
    Client *client = [clients objectAtIndex:indexPath.row];
    
    cell.textLabel.text = client.name;
    cell.imageView.image = client.thumbnail;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    cell.detailTextLabel.text = [formatter stringFromDate: client.birthDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientModel *clientModel = [ClientModel sharedModel];
    NSMutableArray *clients = [[NSMutableArray alloc] initWithArray:clientModel.allClients];
    Client *client = [clients objectAtIndex:indexPath.row];
    
    ClientViewController *clientVC = [[ClientViewController alloc] init];
    clientVC.client = client;
    NSLog(@"available1 %@", [CarModel sharedModel].allCars);
    [self.navigationController pushViewController: clientVC  animated: YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)createItem
{
    ClientViewController *cvc = [[ClientViewController alloc] init];
    
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
