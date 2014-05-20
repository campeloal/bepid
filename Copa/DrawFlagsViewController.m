//
//  DrawFlagsViewController.m
//  Copa
//
//  Created by Alex De Souza Campelo Lima on 5/20/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "DrawFlagsViewController.h"

@interface DrawFlagsViewController ()

@end

@implementation DrawFlagsViewController

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
        _japanFlag = [[JapanView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        _italyFlag = [[ItalyView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        _switzFlag = [[SwitzView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        _chileFlag = [[ChileView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        _greeceFlag = [[GreeceView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        _brazilFlag = [[BrazilView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     _japanFlag.opaque = NO;
    [_japanFlag setNeedsDisplay];
    _italyFlag.opaque = NO;
    [_italyFlag setNeedsDisplay];
    _switzFlag.opaque = NO;
    [_switzFlag setNeedsDisplay];
    _chileFlag.opaque = NO;
    [_chileFlag setNeedsDisplay];
    _greeceFlag.opaque = NO;
    [_greeceFlag setNeedsDisplay];
    _brazilFlag.opaque = NO;
    [_brazilFlag setNeedsDisplay];
    
    [self.view addSubview:_japanFlag];
    [self.view addSubview:_italyFlag];
    [self.view addSubview:_switzFlag];
    [self.view addSubview:_chileFlag];
    [self.view addSubview:_greeceFlag];
    [self.view addSubview:_brazilFlag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
