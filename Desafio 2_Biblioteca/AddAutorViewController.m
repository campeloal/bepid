//
//  AddAutorViewController.m
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "AddAutorViewController.h"

@interface AddAutorViewController ()

@end

@implementation AddAutorViewController

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
    _data = [[NSMutableArray alloc] initWithObjects:@"oi",@"oi", nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar Autor" style: UIBarButtonItemStyleDone target:self action:@selector(goToNextScreen)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}
                                  
                                  
-(void) goToNextScreen
{
    UnicoAutorViewController *uavc = [[UnicoAutorViewController alloc] init];
    [self.navigationController pushViewController:uavc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    return cell;
}

@end
