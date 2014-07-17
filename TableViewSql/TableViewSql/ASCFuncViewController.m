//
//  ASCAuthorViewController.m
//  TableViewSql
//
//  Created by Alex on 17/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "ASCFuncViewController.h"
#import "ASCFunc.h"
#import "ASCFuncDetailsViewController.h"
#import "ASCDetails.h"

@interface ASCFuncViewController ()

@end

@implementation ASCFuncViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self readFuncionario];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.funcs count];
}

-(NSMutableArray*) readFuncionario
{
    _funcs = [[NSMutableArray alloc] init];
    _funcsDetails = [[NSMutableArray alloc] init];
    
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Funcionario.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file %@", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        }
        [self readCadastro];
        [self readSalario];
    }
    
    @catch (NSException *exception) {
         NSLog(@"Problem with prepare statement: %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        return self.funcs;
    }
    
}

-(void) readCadastro
{
    const char *sql = "SELECT * from Cadastro";
    sqlite3_stmt *sqlStatement;
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement: %s", sqlite3_errmsg(db));
    }
    else
    {
        while (sqlite3_step(sqlStatement) == SQLITE_ROW)
        {
            ASCFunc *func = [[ASCFunc alloc] init];
            func.identification = (int) sqlite3_column_text(sqlStatement, 0);
            func.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            func.age = (int) sqlite3_column_text(sqlStatement, 2);
            func.email = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            func.photo = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            
            [self.funcs addObject:func];
        }
    }
    
    sqlite3_finalize(sqlStatement);

}

-(void) readSalario
{
    const char *sql = "SELECT * from Salario";
    sqlite3_stmt *sqlStatement;
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement: %s", sqlite3_errmsg(db));
    }
    else
    {
        while (sqlite3_step(sqlStatement) == SQLITE_ROW)
        {
            ASCDetails *det = [[ASCDetails alloc] init];
            double ident = sqlite3_column_int(sqlStatement, 0);
            double salary = sqlite3_column_double(sqlStatement, 1);
            NSString *month = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            NSString *year = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];

            det.identification = ident;
            det.salary = salary;
            det.month = month;
            det.year = year;
            
            [self.funcsDetails addObject:det];
        }
    }
    
    sqlite3_finalize(sqlStatement);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FuncCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int rowCount = indexPath.row;
    
    ASCFunc *func = [self.funcs objectAtIndex:rowCount];
    cell.textLabel.text = func.name;
    cell.detailTextLabel.text = func.email;

    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"Details"])
    {
        
        // Get reference to the destination view controller
        ASCFuncDetailsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        ASCDetails *det = [self.funcsDetails objectAtIndex:index.row];
        ASCFunc *func = [self.funcs objectAtIndex:index.row];
        vc.salaryText = [NSString stringWithFormat:@"%f", det.salary];
        vc.photoText = func.photo;
        vc.monthText = det.month;
        vc.yearText = det.year;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
