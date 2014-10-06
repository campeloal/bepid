//
//  CarTableViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/29/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "CarTableViewController.h"
#import "CarViewController.h"
#import "CarModel.h"
#import "Car.h"

@interface CarTableViewController ()

@end

@implementation CarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"Carros";
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CarModel *carModel = [CarModel sharedModel];
    NSMutableArray *cars  = [[NSMutableArray alloc] initWithArray:[carModel allCars]];

    int numberCars = 0;
    
    for (Car* car in cars) {
        if (!car.owner) {
            numberCars++;
        }
    }
    
    return numberCars;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    CarModel *carModel = [CarModel sharedModel];
    NSMutableArray *cars = [[NSMutableArray alloc] initWithArray:carModel.allCars];
    Car *car = [cars objectAtIndex:indexPath.row];
    
    cell.textLabel.text = car.model;
    cell.detailTextLabel.text = car.modelYear;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarModel *carModel = [CarModel sharedModel];
    NSMutableArray *cars = [[NSMutableArray alloc] initWithArray:carModel.allCars];
    Car *car = [cars objectAtIndex:indexPath.row];
    
    CarViewController *carVC = [[CarViewController alloc] init];
    carVC.car = car;
    [self.navigationController pushViewController: carVC  animated: YES];
}

- (void)createItem
{
    CarViewController *cvc = [[CarViewController alloc] init];
    
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
