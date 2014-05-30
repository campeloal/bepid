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
        AudioSessionInitialize(NULL, NULL, NULL, NULL);
        AudioSessionSetActive(true);
        
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
    
    [_formView setFrame:CGRectMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    _formView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:_formView];
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height * 2);
    
	self.scrollView.pagingEnabled = YES;
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = 4;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
    
    [self.textField1 setDelegate:self];
    [self.textField2 setDelegate:self];
}

-(void)  volumeChanged:(NSNotification *) note
{
    
    NSLog(@"aumentou volume");
    
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

-(void)  keyboardWillShow:(NSNotification *) note
{
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSLog(@"Keyboard Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // move the view up by 30 pts
    CGRect frame = self.view.frame;
    frame.origin.y = -100;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}

- (void) keyboardDidHide:(NSNotification *)note {
    
    // move the view back to the origin
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}


-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}

@end
