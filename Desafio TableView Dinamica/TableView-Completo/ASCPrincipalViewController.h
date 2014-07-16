//
//  ASCPrincipalViewController.h
//  TableView-Completo
//
//  Created by Alex De Souza Campelo Lima on 7/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCPrincipalViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *numbers;

@end
