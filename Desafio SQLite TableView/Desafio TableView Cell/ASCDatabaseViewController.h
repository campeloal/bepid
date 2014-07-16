//
//  ASCDatabaseViewController.h
//  Desafio TableView Cell
//
//  Created by Alex De Souza Campelo Lima on 7/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ASCDatabaseViewController : UIViewController

@property(strong,nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UITextField *identification;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *photo;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;

- (IBAction)saveData:(id)sender;
- (IBAction)findContact:(id)sender;

@end
