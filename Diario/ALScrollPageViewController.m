//
//  UIScrollView_PagingViewController.m
//  UIScrollView-Paging
//
//  Created by Costa Walcott on 3/2/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "ALScrollPageViewController.h"

@implementation ALScrollPageViewController


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	int numberPages = 5;
    CGRect screenRect = self.view.window.bounds;
	
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:screenRect];
    
    for(int i = 0; i < 5; i++)
    {
        PageView *page = [[PageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * i, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)];
        [page writeText];
        page.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:page];
    }
    
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberPages, scrollView.frame.size.height);
    
	scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
