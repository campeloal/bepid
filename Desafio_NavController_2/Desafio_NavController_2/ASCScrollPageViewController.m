//
//  UIScrollView_PagingViewController.m
//  UIScrollView-Paging
//
//  Created by Costa Walcott on 3/2/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "ASCScrollPageViewController.h"
#import "ASCEditViewController.h"
#import "ASCCarCollection.h"
#define TRINTA_DIAS 2592000

@implementation ALScrollPageViewController

@synthesize scrollView, pageControl;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UINavigationItem *navEditItem = self.navigationItem;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style: UIBarButtonItemStylePlain target:self action:@selector(editCar:)];
        
        navEditItem.rightBarButtonItem = doneButton;
        
    }
    return self;
}

-(IBAction)editCar:(id)sender
{
    
    ASCEditViewController *editVC = [[ASCEditViewController alloc] init];
    editVC.currentCar = self.pageControl.currentPage;
    
   [self.navigationController pushViewController:editVC animated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    pageControlBeingUsed = NO;
	int numberCars = [[ASCCarCollection sharedCarCollection] obterNumberCars];
	
	for (int i = 0; i < numberCars; i++) {
		CGRect frame;
		frame.origin.x = self.scrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.scrollView.frame.size;
        
        
        UIView *carView = [[UIView alloc] initWithFrame:frame];
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
        name.text = [NSString stringWithFormat:@"%@%@",@"Nome: ", [[ASCCarCollection sharedCarCollection] obterNomeIndex: i]];
        UILabel *placa = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
        placa.text = [NSString stringWithFormat:@"%@%@",@"Placa: ", [[ASCCarCollection sharedCarCollection] obterPlacaIndex:i]];
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 40)];
        status.text =  @"Status: ";
        UILabel *statusValue = [[UILabel alloc] initWithFrame:CGRectMake(110, 200, 90, 40)];
        statusValue.text = [[ASCCarCollection sharedCarCollection]obterStatusIndex:i];
        [self checkStatusColor:i Label:statusValue];
        
        UILabel *dias = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200, 40)];
        dias.text = @"Dias: ";
        
        UILabel *diasValue = [[UILabel alloc] initWithFrame:CGRectMake(240, 200, 30, 40)];
        diasValue.text = [NSString stringWithFormat:@"%d",[[ASCCarCollection sharedCarCollection] obterDias:i] ];
        
        [self checkDias:i Status:statusValue Dias:diasValue];
        [self checkAtraso:i Status:statusValue];
        
        [carView addSubview:name];
        [carView addSubview:placa];
        [carView addSubview:status];
        [carView addSubview:statusValue];
        [carView addSubview:dias];
        [carView addSubview:diasValue];
        carView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:carView];
		
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * numberCars, 0);
    
	self.scrollView.pagingEnabled = YES;
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = numberCars;
}

-(void) checkAtraso: (int) index Status: (UILabel*) status
{
    NSDateFormatter* fmt = [NSDateFormatter new];
    [fmt setDateFormat:@"dd/MM/yy"];
    NSDate* date = [fmt dateFromString:[[ASCCarCollection sharedCarCollection] obterDataFimIndex:index]];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    
    if ((time > TRINTA_DIAS) && ([status.text isEqualToString:@"Alugado"]))
    {
        
        status.backgroundColor = [UIColor redColor];
        status.textColor = [UIColor whiteColor];
    }
}

-(void) checkDias: (int) index Status: (UILabel*) label Dias: (UILabel*) dias
{
    if (([[ASCCarCollection sharedCarCollection] obterDias:index] > 30) && ([label.text isEqualToString:@"Disponível"])) {
        dias.backgroundColor = [UIColor blueColor];
    }
    
}


-(void) checkStatusColor: (int) index Label: (UILabel*) label
{
    if([[[ASCCarCollection sharedCarCollection] obterStatusIndex:index] isEqualToString:@"Alugado"])
    {
        label.textColor = [UIColor redColor];
    }
    else if ([[[ASCCarCollection sharedCarCollection] obterStatusIndex:index] isEqualToString:@"Disponível"])
    {
        label.textColor = [UIColor greenColor];
    }
    else
    {
        label.textColor = [UIColor orangeColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
