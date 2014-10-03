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

@property NSMutableArray *avaliable;

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
// Retornar o número de carros do cliente caso a tableView seja a do cliente
// Retornar o número de carros disponíveis caso a tableView seja a de carros disponíveis
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
// Caso a tabelView seja a do cliente, retorne uma UITableViewCell preenchida com os dados do carro do cliente.
// Caso a tabelView seja a de carros disponíveis, retorne uma UITableViewCell preenchida com os dados do carro disponível.
    return nil;
}

- (IBAction)addButtonClick:(id)sender {
    NSIndexPath *selectedIndexPath = [self.availableTableView indexPathForSelectedRow];
    
    if (selectedIndexPath) {
        Car *c = [self.avaliable objectAtIndex:selectedIndexPath.row];
        
        [self.avaliable removeObject:c];
        [self.acquired addObject:c];
        
        [self.availableTableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSIndexPath *addIndexPath = [NSIndexPath indexPathForItem:self.acquired.count - 1 inSection:0];
        [self.acquiredTableView insertRowsAtIndexPaths:@[addIndexPath] withRowAnimation:UITableViewRowAnimationFade];
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
        
        [self.acquiredTableView deleteRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSIndexPath *addIndexPath = [NSIndexPath indexPathForItem:self.avaliable.count - 1 inSection:0];
        [self.availableTableView insertRowsAtIndexPaths:@[addIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
