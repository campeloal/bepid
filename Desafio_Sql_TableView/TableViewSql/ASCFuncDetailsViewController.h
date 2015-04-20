//
//  ASCFuncDetailsViewController.h
//  TableViewSql
//
//  Created by Alex De Souza Campelo Lima on 7/17/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCFuncDetailsViewController : UIViewController

@property (nonatomic) NSString *salaryText;
@property (nonatomic) NSString *photoText;
@property (nonatomic) NSString *yearText;
@property (nonatomic) NSString *monthText;
@property (weak, nonatomic) IBOutlet UILabel *salary;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *month;

@end
