//
//  AddAutorViewController.h
//  App2
//
//  Created by Alex De Souza Campelo Lima on 5/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnicoAutorViewController.h"

@interface AddAutorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *data;

@end
