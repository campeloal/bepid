//
//  ALScrollPageViewController.h
//  DesafioScroll
//
//  Created by Alex on 5/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALScrollPageViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>
{
	
	BOOL isEven;
}
@property (strong, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet UILabel *myNumber;
@property (weak, nonatomic) IBOutlet UITextField *OddOrEven;
@property (weak, nonatomic) IBOutlet UIImageView *myNumberIm;
@property (weak, nonatomic) IBOutlet UITextField *Number;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (weak, nonatomic) IBOutlet UILabel *winner;
@property (strong, nonatomic) IBOutlet UIView *winView;
@property (weak, nonatomic) IBOutlet UILabel *appNumber;
@property (weak, nonatomic) IBOutlet UIImageView *appNumberIm;


-(IBAction)checkNumber:(id)sender;
-(IBAction)checkOddOrEven:(id)sender;
-(IBAction)chooseOddOrEven:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;


@end
