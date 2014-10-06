//
//  BrandTableViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/29/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "BrandTableViewController.h"
#import "BrandViewController.h"
#import "BrandModel.h"
#import "Brand.h"

@interface BrandTableViewController ()

@end

@implementation BrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"Marcas";
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BrandModel *brandModel = [BrandModel sharedModel];
    return [brandModel.allBrands count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    BrandModel *brandModel = [BrandModel sharedModel];
    NSMutableArray *brands = [[NSMutableArray alloc] initWithArray:brandModel.allBrands];
    Brand *currentBrand = [brands objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentBrand.brand;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandModel *brandModel = [BrandModel sharedModel];
    NSMutableArray *brands = [[NSMutableArray alloc] initWithArray:brandModel.allBrands];
    Brand *brand = [brands objectAtIndex:indexPath.row];
    
    BrandViewController *brandVC = [[BrandViewController alloc] init];
    brandVC.brand = brand;
    [self.navigationController pushViewController: brandVC  animated: YES];

}

- (void)createItem
{
    BrandViewController *bvc = [[BrandViewController alloc] init];
    
    [self.navigationController pushViewController:bvc animated:YES];
}

@end
