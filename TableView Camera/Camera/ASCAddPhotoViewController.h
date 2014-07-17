//
//  ASCAddPhotoViewController.h
//  Camera
//
//  Created by Alex De Souza Campelo Lima on 7/17/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAddPhotoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tbView;
}

@property (nonatomic,retain) NSMutableArray *data;
@property (nonatomic,retain) NSMutableArray *photos;
@property (nonatomic) int currentIndex;

@end
