//
//  DiarioViewController.m
//  DesafioDiario
//
//  Created by Alex on 5/22/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "DiarioViewController.h"

@interface DiarioViewController ()

@end

@implementation DiarioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWindowSize: (CGRect) size
{
    self = [super init];
    if (self) {
        windowSize = size;
    }
    return self;
}

- (void)loadView {
	[super loadView];

    // Do any additional setup after loading the view.
    CGRect screenRect = windowSize;
    
    //adicionando o uiscrollview na tela.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:screenRect];
    
    int numberOfPages = 5;
    
    NSMutableArray *dates = [[NSMutableArray alloc] initWithObjects:@"19/05/2014", @"20/05/2014", @"21/05/2014", @"22/05/2014", @"23/05/2014", nil];
    
    NSMutableArray *strings = [[NSMutableArray alloc] initWithObjects:@"Primeira Aula", @"Segunda Aula", @"Terceira Aula", @"Quarta Aula", @"Quinta Aula", nil];
    
    for(int i = 0; i < numberOfPages; i++)
    {
        PaginaView *myView = [[PaginaView alloc] initWithFrame: CGRectMake(screenRect.size.width*i, screenRect.origin.y, screenRect.size.width, screenRect.size.height)];
        myView.backgroundColor = [UIColor whiteColor];
        
        [myView writeTopic: @"Topico" InFrame:CGRectMake(10,50, 80, 20)];
        [scrollView addSubview:myView];
        [myView writeText:[strings objectAtIndex:i] InFrame:CGRectMake(30, 80, 200, 300)];
        [myView writeText:[dates objectAtIndex:i] InFrame:CGRectMake(screenRect.size.width - 100,10, 100, 50)];
        [scrollView addSubview:myView];
    }
  
    scrollView.contentSize = CGSizeMake(screenRect.size.width * numberOfPages, screenRect.size.height);
    scrollView.pagingEnabled = YES;
    
    self.view = scrollView;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
