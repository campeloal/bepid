//
//  ASCScrollViewController.m
//  DesafioDelegate
//
//  Created by Alex De Souza Campelo Lima on 6/24/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCScrollViewController.h"
#define SCROLL_WIDTH 500
#define SCROLL_HEIGHT 150

@interface ASCScrollViewController ()
{
    UILabel *redLabel,*blackLabel;
    BOOL isBlue;
    int greenHeight, blueHeight;
}

@end

@implementation ASCScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        greenHeight = SCROLL_HEIGHT + 10;
        blueHeight = SCROLL_HEIGHT + 10;
    }
    return self;
}

-(void) createLabels: (UIScrollView*) scroll
{
    for(int i = 0; i < 6; i++)
    {
        UIButton *grayButton = [[UIButton alloc] initWithFrame:CGRectMake(100*i + 10, 20, 50, 100)];
        grayButton.backgroundColor = [UIColor grayColor];
        [scroll addSubview:grayButton];
    }
}

-(void)addScrollView{
    greenScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(20, 20, 280, 160)];
    [greenScrollView addSubview:redLabel];
    [greenScrollView setBackgroundColor:[UIColor greenColor]];
    greenScrollView.contentSize = CGSizeMake(SCROLL_WIDTH,SCROLL_HEIGHT);
    greenScrollView.delegate = self;
    [self createLabels:greenScrollView];
    [self.view addSubview:greenScrollView];
    
    blueScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 250, 280, 160)];
    [blueScrollView setBackgroundColor:[UIColor blueColor]];
    blueScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, SCROLL_HEIGHT);
    [self createLabels:blueScrollView];
    blueScrollView.delegate = self;
    [self.view addSubview:blueScrollView];
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    if(scrollView == greenScrollView)
    {
        isBlue = NO;
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Scroll" message:@"Deseja aumentar o scroll verde?" delegate:self cancelButtonTitle:@"Diminuir" otherButtonTitles:@"Aumentar",nil];
        [alert show];
    }
    else if(scrollView == blueScrollView)
    {
        isBlue = YES;
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Scroll" message:@"Deseja aumentar o scroll azul?" delegate:self cancelButtonTitle:@"Diminuir" otherButtonTitles:@"Aumentar",nil];
        [alert show];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (isBlue) {
        
        if(buttonIndex == 0)
        {
            blueHeight -= 50;
            CGRect scrollFrame = blueScrollView.frame;
            scrollFrame.size.height = blueHeight;
            blueScrollView.frame = scrollFrame;
            blueScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, blueHeight);
            
            greenHeight += 50;
            scrollFrame = greenScrollView.frame;
            scrollFrame.size.height = greenHeight;
            greenScrollView.frame = scrollFrame;
            greenScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, greenHeight);
        }
        else if(buttonIndex == 1)
        {
            blueHeight += 50;
            CGRect scrollFrame = blueScrollView.frame;
            scrollFrame.size.height = blueHeight;
            blueScrollView.frame = scrollFrame;
            blueScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, blueHeight);
            
            greenHeight -= 50;
            scrollFrame = greenScrollView.frame;
            scrollFrame.size.height = greenHeight;
            greenScrollView.frame = scrollFrame;
            greenScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, greenHeight);
        }
    }
    else
    {
        if(buttonIndex == 0)
        {
            blueHeight += 50;
            CGRect scrollFrame = blueScrollView.frame;
            scrollFrame.size.height = blueHeight;
            blueScrollView.frame = scrollFrame;
            blueScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, blueHeight);
            
            greenHeight -= 50;
            scrollFrame = greenScrollView.frame;
            scrollFrame.size.height = greenHeight;
            greenScrollView.frame = scrollFrame;
            greenScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, greenHeight);
        }
        else if(buttonIndex == 1)
        {
            blueHeight -= 50;
            CGRect scrollFrame = blueScrollView.frame;
            scrollFrame.size.height = blueHeight;
            blueScrollView.frame = scrollFrame;
            blueScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, blueHeight);
            
            greenHeight += 50;
            scrollFrame = greenScrollView.frame;
            scrollFrame.size.height = greenHeight;
            greenScrollView.frame = scrollFrame;
            greenScrollView.contentSize = CGSizeMake(SCROLL_WIDTH, greenHeight);
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addScrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
