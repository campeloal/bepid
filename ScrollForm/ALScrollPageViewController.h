//
//  ALScrollPageViewController.h
//  DesafioScroll
//
//  Created by Alex on 5/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import "BrazilView.h"
#import "GreeceView.h"
#import "ChileView.h"

@interface ALScrollPageViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>
{
    UIScrollView* scrollView;
	UIPageControl* pageControl;
	
	BOOL pageControlBeingUsed;
}
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

- (IBAction)changePage;


@end
