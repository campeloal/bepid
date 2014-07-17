//
//  ASCAuthorViewController.h
//  TableViewSql
//
//  Created by Alex on 17/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ASCFuncViewController : UITableViewController
{
    sqlite3 *db;
}

@property (nonatomic,retain) NSMutableArray *funcs;
@property (nonatomic,retain) NSMutableArray *funcsDetails;

-(NSMutableArray*) readFuncionario;

@end
