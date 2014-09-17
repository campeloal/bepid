//
//  ASCTableViewController.h
//  Desafio_Split_View_Controller
//
//  Created by Alex De Souza Campelo Lima on 9/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCDetailViewController.h"

@interface ASCTableViewController : UITableViewController

@property (nonatomic) ASCDetailViewController *detailViewController;
@property (nonatomic) IBOutlet UITableView *tbView;

@end
