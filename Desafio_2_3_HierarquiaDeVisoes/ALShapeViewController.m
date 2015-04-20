//
//  ALShapeViewController.m
//  Desafio2_HierVisao
//
//  Created by Alex De Souza Campelo Lima on 5/19/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALShapeViewController.h"

@interface ALShapeViewController ()

@end

@implementation ALShapeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        shapes = [[NSMutableArray alloc] init];
        _sv = [[ALShapeView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void) createView
{
    
    Shape *singleShape = [[Shape alloc] init];
    [singleShape setX:_x];
    [singleShape setY:_y];
    [singleShape setWidth:_width];
    [singleShape setHeight:_height];
    [singleShape setIsRect:_isRect];
    [singleShape setColor:_color];
    [shapes addObject:singleShape];
    [_sv setShapes:shapes];
    [_sv setNeedsDisplay];
    _sv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_sv];
    
    

}


@end
