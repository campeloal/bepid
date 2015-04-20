//
//  UIScrollView_PagingViewController.m
//  UIScrollView-Paging
//
//  Created by Costa Walcott on 3/2/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "ALScrollPageViewController.h"

@implementation ALScrollPageViewController

@synthesize scrollView, pageControl;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	pageControlBeingUsed = NO;
	int numberFlags = 3;
	
	for (int i = 0; i < numberFlags; i++) {
		CGRect frame;
		frame.origin.x = self.scrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.scrollView.frame.size;
		
        if(i == 0)
        {
            UIView *subview = [[BrazilView alloc] initWithFrame:frame];
            subview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:subview];
        }
        else if(i == 1)
        {
            UIView *subview = [[ChileView alloc] initWithFrame:frame];
            subview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:subview];
        }
        else if( i == 2)
        {
            UIView *subview = [[GreeceView alloc] initWithFrame:frame];
            subview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:subview];
        }
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    
	self.scrollView.pagingEnabled = YES;
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = 3;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
     
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (IBAction)changePage {
	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];
	pageControlBeingUsed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
