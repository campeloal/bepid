//
//  ViewController.m
//  Storyboard_Desafio_5
//
//  Created by Alex De Souza Campelo Lima on 10/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ViewController.h"
#import "CarTableViewCell.h"
#import "CarCollectionViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.carImages = [[NSArray alloc] initWithObjects:@"car.jpg",@"car2.jpg",@"car3.jpg",@"car4.jpg", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.carImages.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"carCell";
    CarTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:[self.carImages objectAtIndex:indexPath.row]];
    cell.carImage.image = image;
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_carImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"car_cell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[self.carImages objectAtIndex:indexPath.row]];
    
    cell.carImage.image = image;
    
    return cell;
}



@end
