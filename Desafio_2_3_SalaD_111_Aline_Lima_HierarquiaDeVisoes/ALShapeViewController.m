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
        _shapes = [[NSMutableArray alloc] init];
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
    [_sv setX:_x];
    [_sv setY:_y];
    [_sv setWidth:_width];
    [_sv setHeight:_height];
    [_sv setColor:_color];
    [_sv setIsRect:_isRect];
    [_sv setNeedsDisplay];
    _sv.backgroundColor = [UIColor whiteColor];
    
    if([_shapes count] > 0)
    {
        for(Shape* shape in _shapes)
        {
            NSLog(@"Entei");
            [_sv setX: [shape x]];
            [_sv setY: [shape y]];
            [_sv setWidth:[shape width]];
            [_sv setHeight:[shape height]];
            [_sv setColor:[shape color]];
            [_sv setIsRect:[shape isRect]];
            [_sv setNeedsDisplay];
        }
    }
    Shape *shape = [[Shape alloc] init];
    if(_isRect)
    {
        [shape setColor:_color];
        [shape setX: _x];
        [shape setY: _y];
        [shape setWidth:_width];
        [shape setHeight:_height];
        [shape setIsRect:_isRect];
        [_shapes addObject: shape];
    }
    else
    {
        [shape setColor:_color];
        [shape setX: _x];
        [shape setY: _y];
        [shape setWidth:_width];
        [shape setHeight:_height];
        [shape setIsRect:_isRect];
        [_shapes addObject: shape];
    }
    
    [self.view addSubview:_sv];
}



@end
