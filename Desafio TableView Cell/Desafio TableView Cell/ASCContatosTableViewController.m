//
//  ASCContatosTableViewController.m
//  Desafio TableView Cell
//
//  Created by Alex De Souza Campelo Lima on 7/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCContatosTableViewController.h"
#import "ASCCustomTableViewCell.h"
#import "ASCDetalhesViewController.h"

@interface ASCContatosTableViewController ()

@end

@implementation ASCContatosTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"plist"];
    self.contatosArray = [NSArray arrayWithContentsOfFile:path];
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
    
    return [self.contatosArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ASCCustomTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    self.contatoDicionario = self.contatosArray[indexPath.row];
    
    NSString *primeiroNome = self.contatoDicionario[@"firstName"];
    NSString *segundoNome = self.contatoDicionario[@"lastName"];
    NSString *imagem = self.contatoDicionario[@"imageName"];
    
    
    UIImage *image = [UIImage imageNamed:imagem];
    
//    cell.textLabel.text = primeiroNome;
//    cell.detailTextLabel.text = segundoNome;
//    cell.imageView.image = image;
    
    customCell.customPrimeiroNome.text = primeiroNome;
    customCell.customSegundoNome.text = segundoNome;
    customCell.customImagem.image = image;
    
    return customCell;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        
        // Get reference to the destination view controller
        ASCDetalhesViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        self.contatoDicionario = self.contatosArray[index.row];
        
        vc.primeiroNomeText = self.contatoDicionario[@"firstName"];
        vc.segundoNomeText = self.contatoDicionario[@"lastName"];
        vc.imagemText = self.contatoDicionario[@"imageName"];
    }
}


@end
