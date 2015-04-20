//
//  ClientCarViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 10/2/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "ClientCarViewController.h"
#import "CarModel.h"
#import "Car.h"

@interface ClientCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *acquiredTableView;
@property (weak, nonatomic) IBOutlet UITableView *availableTableView;

@end

@implementation ClientCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Adquiridos";
    
    _avaliable = [[NSMutableArray alloc] initWithArray:[CarModel sharedModel].allCars];
    
    if (!_acquired) {
        _acquired = [[NSMutableArray alloc] init];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.availableTableView) {
        return [[[CarModel sharedModel] allCars] count];
    }
    else if (tableView == self.acquiredTableView)
    {
        return [self.acquired count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.acquiredTableView)
    {
        if ( indexPath.row < [self.acquired count])
        {
        
        Car *car = [self.acquired objectAtIndex:indexPath.row];
            
        if (car)
        {
            cell.textLabel.text = car.model;
            cell.detailTextLabel.text = car.modelYear;
        }
            
        }
        
    }
    
    else if (tableView == self.availableTableView)
    {
        if (indexPath.row < [self.avaliable count]) {
            Car *car = [self.avaliable objectAtIndex:indexPath.row];
            
            if (car) {
                cell.textLabel.text = car.model;
                cell.detailTextLabel.text = car.modelYear;
            }
            
            
        }
    }
    else
    {
        cell.textLabel.text = @"";
    }
    
    return cell;
}

- (IBAction)addButtonClick:(id)sender {
    NSIndexPath *selectedIndexPath = [self.availableTableView indexPathForSelectedRow];
    NSLog(@"Available %@", self.avaliable);
    
    NSLog(@"Acquired %@", self.acquired);
    
    
    if (selectedIndexPath) {
        Car *c = [self.avaliable objectAtIndex:selectedIndexPath.row];
        
        [self.avaliable removeObject:c];
        [self.acquired addObject:c];
        
        [self.availableTableView reloadData];
        
        [self.acquiredTableView reloadData];
        
//        [self.availableTableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        NSIndexPath *addIndexPath = [NSIndexPath indexPathForItem:self.acquired.count - 1 inSection:0];
//        [self.acquiredTableView insertRowsAtIndexPaths:@[addIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)removeButtonClick:(id)sender {
    NSIndexPath *selectedIndexPath = [self.acquiredTableView indexPathForSelectedRow];
    
    NSLog(@"Adq: %@",self.acquired);
    
    if (selectedIndexPath) {
        NSLog(@"Index: %d", selectedIndexPath.row);
        Car *c = [self.acquired objectAtIndex:selectedIndexPath.row];
        NSLog(@"Car: %@", [c description]);
        
        [self.acquired removeObject:c];
        [self.avaliable addObject:c];
        
        [[CarModel sharedModel] addCars:self.avaliable];
        
        
        [self.acquiredTableView reloadData];
        [self.availableTableView reloadData];
        
        
        
//        [self.acquiredTableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        NSIndexPath *addIndexPath = [NSIndexPath indexPathForItem:self.avaliable.count - 1 inSection:0];
//        [self.availableTableView insertRowsAtIndexPaths:@[addIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL) checkCarExists: (Car*) checkCar
{
    for (Car *car in self.avaliable) {
        if (checkCar == car) {
            return YES;
        }
    }
    
    return NO;
}

@end
