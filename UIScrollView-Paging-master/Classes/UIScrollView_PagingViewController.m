//
//  UIScrollView_PagingViewController.m
//  UIScrollView-Paging
//
//  Created by Costa Walcott on 3/2/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "UIScrollView_PagingViewController.h"

@implementation UIScrollView_PagingViewController

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
            [subview release];
        }
        else if(i == 1)
        {
            UIView *subview = [[ChileView alloc] initWithFrame:frame];
            subview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:subview];
            [subview release];
        }
        else if( i == 2)
        {
            UIView *subview = [[GreeceView alloc] initWithFrame:frame];
            subview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:subview];
            [subview release];
        }
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
	
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = 3;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
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
	// Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
	self.pageControl = nil;
}


- (void)dealloc {
	[scrollView release];
	[pageControl release];
    [super dealloc];
}

@end
