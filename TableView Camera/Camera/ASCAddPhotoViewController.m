//
//  ASCAddPhotoViewController.m
//  Camera
//
//  Created by Alex De Souza Campelo Lima on 7/17/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCAddPhotoViewController.h"
#import "ASCViewController.h"
#import "ASCTableViewCell.h"

@interface ASCAddPhotoViewController ()

@end

@implementation ASCAddPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [[NSMutableArray alloc] init];
    _photos = [[NSMutableArray alloc] init];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToNextScreen)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.title = @"Photos list";
}

-(void) goToNextScreen
{
    ASCViewController *vc = [[ASCViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tbView = tableView;
    return [_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableId = @"myCell";
    ASCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableId];
    
    if(cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName: @"ASCTableViewCell" bundle:nil] forCellReuseIdentifier:simpleTableId];
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableId];
    }
    cell.name.text = [_data objectAtIndex:indexPath.row];
    UIImageView* imageView = [_photos objectAtIndex:indexPath.row];
    cell.imageView.image = imageView.image;
    _currentIndex = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(void) sendName:(NSString*) photoName Image: (UIImageView*) image
{
    [_data addObject:photoName];
    [_photos addObject:image];
    [tbView reloadData];
}

@end
