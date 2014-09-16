//
//  ASCPrincipalViewController.m
//  TableView-Completo
//
//  Created by Alex De Souza Campelo Lima on 7/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCPrincipalViewController.h"
#import "ASCAppDelegate.h"

@interface ASCPrincipalViewController ()

@end

@implementation ASCPrincipalViewController

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
    //self.numbers = [[NSMutableArray alloc] initWithObjects:@"Um",@"Dois",@"Três",@"Quatro",@"Cinco",
    //@"Seis",@"Sete",@"Oito",@"Nove",@"Dez",nil];
    
    self.title = @"Minha Table View";
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(alertNovoObjeto)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self
                action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.myTableView addSubview:refresh];
    
    
    ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *path = [delegate itemArchivePath];
    delegate.numbers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (!delegate.numbers) {
        delegate.numbers = [[NSMutableArray alloc] init];
    }
    
}

-(void)refreshView:(UIRefreshControl *)refresh {
    
    [self alertNovoObjeto];
    [refresh endRefreshing];

}



-(void) alertNovoObjeto
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Digite o número" message:@"" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSString *texto = [alertView textFieldAtIndex:0].text;
        
//        if(!self.numbers)
//        {
//            self.numbers = [[NSMutableArray alloc] init];
//        }
        
        ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication]delegate];
        [delegate.numbers insertObject:texto atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.myTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication] delegate];
    return  delegate.numbers.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication] delegate];
    cell.textLabel.text = [delegate.numbers objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:@"pokemon.png"];
    cell.imageView.image = image;
    
    return cell;
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.myTableView setEditing:editing animated:animated];
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication] delegate];
        [delegate.numbers removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    ASCAppDelegate *delegate = (ASCAppDelegate *) [[UIApplication sharedApplication]delegate];
    [aCoder encodeObject:delegate.numbers forKey:@"numbers"];
}


-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        ASCAppDelegate *delegate = (ASCAppDelegate *)[[UIApplication sharedApplication]delegate];
        delegate.numbers = [aDecoder decodeObjectForKey:@"numbers"];
    }
    return self;
}

@end
