//
//  AddAutorViewController.m
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "AutorTableViewController.h"

@interface AutorTableViewController ()

@end

@implementation AutorTableViewController

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
    _data = [[NSMutableArray alloc] init];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToNextScreen)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}
                                  
                                  
-(void) goToNextScreen
{
    UnicoAutorViewController *uavc = [[UnicoAutorViewController alloc] init];
    uavc.delegate = self;
    [self.navigationController pushViewController:uavc animated:YES];
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
    static NSString *simpleTableId = @"TableId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableId];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableId];
    }
    
    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
    cell.textLabel.textColor =[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    cell.backgroundColor = [UIColor colorWithRed:0.82 green:0.71 blue:0.55 alpha:1.0];
    return cell;
}

-(void) sendDataToPrevVC:(NSString*) data
{
    [_data addObject:data];
    [tbView reloadData];
    
     
}



@end
