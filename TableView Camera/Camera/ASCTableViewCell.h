//
//  ASCTableViewCell.h
//  Camera
//
//  Created by Alex De Souza Campelo Lima on 7/17/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCTableViewCell : UITableViewCell


@property (nonatomic,weak) IBOutlet UIImageView* image;
@property (nonatomic,weak) IBOutlet UILabel *name;

@end
