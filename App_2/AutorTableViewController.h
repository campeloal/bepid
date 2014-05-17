//
//  AddAutorViewController.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnicoAutorViewController.h"

@interface AutorTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tbView;
}

@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) UnicoAutorViewController *avc;

@end
