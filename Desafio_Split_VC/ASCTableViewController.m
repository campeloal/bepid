//
//  ASCTableViewController.m
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCTableViewController.h"
#import "ASCItem.h"
#import "ASCItemStore.h"

@interface ASCTableViewController ()

@property (nonatomic) ASCItemStore *itemStored;
@property (nonatomic) BOOL isEditing;
@property (nonatomic) UIBarButtonItem *editButton;

@end

@implementation ASCTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _isEditing = NO;
    
    _itemStored = [ASCItemStore sharedStore];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    _editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem = _editButton;
    
}

-(void) addItem
{
    [_itemStored createItem];
    [_tbView reloadData];
}

-(void) editItem
{
    if (!_isEditing) {
        [self setEditing:YES animated:YES];
        _isEditing = YES;
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editItem)];
        self.navigationItem.leftBarButtonItem = doneButton;
    }
    else
    {
        [self setEditing:NO animated:YES];
        _isEditing = NO;
        self.navigationItem.leftBarButtonItem = _editButton;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_itemStored allItems] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    int index = (int) indexPath.row;
    
    NSString* itemName = [[[_itemStored allItems] objectAtIndex: index] description];
    
    cell.textLabel.text = itemName;
    
    return cell;

}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_itemStored removeItemAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ASCItem* itemToMove = [[_itemStored allItems] objectAtIndex:fromIndexPath.row];
  //  [_itemStored removeItemAtIndex:fromIndexPath.row];
    
  //  [_itemStored addItem:itemToMove AtIndex:toIndexPath.row];
    
    [_itemStored moveItem:itemToMove AtIndex:(int)toIndexPath.row FromIndex:(int) fromIndexPath.row];
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        _detailViewController = [[ASCDetailViewController alloc] init];
    }
    
    
    _detailViewController.item = [[_itemStored allItems] objectAtIndex: indexPath.row];
    
    [_detailViewController refreshInfo];
    
    
    if (!self.splitViewController) {
        // Push the view controller.
        [self.navigationController pushViewController:_detailViewController animated:YES];
        
    }
    
}


@end
