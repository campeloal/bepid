//
//  ASCViewController.m
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCView.h"

@interface ASCViewController ()

@end

@implementation ASCViewController
{
    ASCView *view;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    view = [[ASCView alloc] initWithFrame:CGRectZero];
    //view.path = [self getPath];
    self.view = view;
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

//-(NSString*) getPath
//{
//    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"paint.plist"];
//}

-(void) saveInFile
{
    [[view shapesProperties] writeToFile: [view getPath] atomically:YES];
    //NSMutableArray *teste = [[NSMutableArray alloc] initWithContentsOfFile:[view getPath]];
    //NSLog(@"%@",teste);
}


@end
