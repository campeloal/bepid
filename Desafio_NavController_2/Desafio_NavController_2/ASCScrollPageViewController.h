//
//  ALScrollPageViewController.h
//  DesafioScroll
//
//  Created by Alex on 5/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALScrollPageViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* scrollView;
	UIPageControl* pageControl;
	
	BOOL pageControlBeingUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

- (IBAction)changePage;

@end
