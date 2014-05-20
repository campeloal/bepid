//
//  ALShapeViewController.h
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALShapeView.h"
#import "Shape.h"

@interface ALShapeViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *shapes;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic, retain) ALShapeView *sv;
@property (nonatomic) BOOL isRect;


@end
