//
//  DrawFlagsViewController.h
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JapanView.h"
#import "ItalyView.h"
#import "SwitzView.h"
#import "ChileView.h"
#import "GreeceView.h"
#import "BrazilView.h"

@interface DrawFlagsViewController : UIViewController

@property (nonatomic, retain) JapanView* japanFlag;
@property (nonatomic, retain) ItalyView* italyFlag;
@property (nonatomic, retain) SwitzView* switzFlag;
@property (nonatomic, retain) ChileView* chileFlag;
@property (nonatomic, retain) GreeceView* greeceFlag;
@property (nonatomic, retain) BrazilView* brazilFlag;

@end
