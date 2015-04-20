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

    isEven = YES;
    [_formView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    
    [_winView setFrame:CGRectMake(self.scrollView.frame.size.width, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    
    [self.scrollView addSubview:_formView];
    [self.scrollView addSubview:_winView];
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height * 1.4);
    
    self.scrollView.scrollEnabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];
    [self.Number setDelegate:self];
    _myNumberIm.transform = CGAffineTransformMakeRotation(M_PI);
    
}




- (void)scrollViewDidScroll:(UIScrollView *)sender {
	
    if(self.scrollView.contentOffset.x == _formView.frame.origin.x)
    {
        self.scrollView.scrollEnabled = NO;
    }
}


-(IBAction)play:(id)sender
{
    
    [self checkWinner];
    [self.scrollView setContentOffset: CGPointMake(self.scrollView.frame.size.width, self.scrollView.frame.origin.y) animated: YES];
    self.scrollView.scrollEnabled = YES;
    
}

-(void) displayNumbers: (int) myNumber App: (int) appNumber
{
    NSString *imageName = @"";
    
    switch (myNumber) {
        case 0:
            imageName = @"zero.jpg";
            break;
            
        case 1:
            imageName = @"one.jpg";
            break;
            
        case 2:
            imageName = @"two.jpg";
            break;
        
        case 3:
            imageName = @"three.jpg";
            break;
            
        case 4:
            imageName = @"four.jpg";
            break;
        
        case 5:
            imageName = @"five.jpg";
            break;
            
        default:
            break;
    }
    
    NSString *imageName2 = @"";
    
    switch (appNumber) {
        case 0:
            imageName2 = @"zero.jpg";
            break;
            
        case 1:
            imageName2 = @"one.jpg";
            break;
            
        case 2:
            imageName2 = @"two.jpg";
            break;
            
        case 3:
            imageName2 = @"three.jpg";
            break;
            
        case 4:
            imageName2 = @"four.jpg";
            break;
            
        case 5:
            imageName2 = @"five.jpg";
            break;
            
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    [_myNumberIm setImage:image];
    
    UIImage *image2 = [UIImage imageNamed:imageName2];
    [_appNumberIm setImage:image2];
}

-(void) checkWinner
{
    int appNumber = arc4random() % 5;
    int result = [_Number.text intValue] + appNumber;
    
    
    if(result % 2 == 0)
    {
        if(isEven)
        {
            _winner.text = @"Venceu";
        }
        else
        {
            _winner.text = @"Perdeu";
        }
        
    }
    else
    {
        if(!isEven)
        {
            _winner.text = @"Venceu";
        }
        else
        {
            _winner.text = @"Perdeu";
        }
    }
    
    _myNumber.text = _Number.text;
    _appNumber.text = [NSString stringWithFormat:@"%d",appNumber];
    [self displayNumbers:[_myNumber.text intValue]  App:appNumber];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(IBAction)checkNumber:(id)sender
{
    if([_Number.text intValue] > 5)
    {
        _Number.text = @"5";
    }else if([_Number.text intValue] < 0)
    {
        _Number.text = @"0";
    }

    
}

-(IBAction)checkOddOrEven:(id)sender
{
    if(![_OddOrEven.text isEqual:@"par"] || ![_OddOrEven.text isEqual:@"impar"])
    {
        _OddOrEven.text = @"par";
    }
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)chooseOddOrEven:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        isEven = YES;
    }
    else{
        isEven = NO;
    }
    
}

-(void)  keyboardWillShow:(NSNotification *) note
{
  /*  NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSLog(@"Keyboard Height: %f Width: %f", kbSize.height, kbSize.width); */
    
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


@end
