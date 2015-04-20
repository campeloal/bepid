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
	
	pageControlBeingUsed = NO;
	int numberOfPeople = 15;
    NSMutableArray *nomes = [[NSMutableArray alloc] initWithObjects:@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João",@"João", nil];
    
    NSMutableArray *idades = [[NSMutableArray alloc] initWithObjects:@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22",@"22", nil];
	
	for (int i = 0; i < numberOfPeople; i++) {
		
        [self createFotoViewWithName:[nomes objectAtIndex:i] andAge:[idades objectAtIndex:i] andPhoto: nil andStartPosition: i];
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 15, self.scrollView.frame.size.height);
    
	self.scrollView.pagingEnabled = YES;
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = numberOfPeople;
}

-(void) createFotoViewWithName: (NSString *) name andAge: (NSString *) age andPhoto: (UIImage *) photo andStartPosition: (int) xPosition{
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * xPosition;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    FotosView *subview = [[FotosView alloc] initWithFrame:frame];
    [subview setName:name];
    [subview setAge: age];
    [subview setImage:@"Aerodactyl.png"];
    [subview drawImage];
    subview.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:subview];
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
