//
//  BPDInfoTabViewController.m
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BPDInfoTabViewController.h"
#import "BPDImage.h"

@interface BPDInfoTabViewController ()
{
    int badgeValue,nTabs, startPosName;
    UITextView *tabNames;
}

@end

@implementation BPDInfoTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Info";
        UIImage *image = [UIImage imageNamed:@"view2.png"];
        self.tabBarItem.image = [BPDImage imageWithImage: image scaledToSize:CGSizeMake(20, 20)];
        badgeValue = 0;
        tabNames = [[UITextView alloc] initWithFrame:CGRectMake(50, 130, 200, 200)];
        tabNames.scrollEnabled = YES;
        tabNames.backgroundColor = [[UIColor alloc] initWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        tabNames.text = @"Info Create";
        [self.view addSubview:tabNames];
        nTabs = 2;
        _numberTabs.text = [NSString stringWithFormat:@"%d",nTabs];
        startPosName = 1;
    
    }
    return self;
}

- (IBAction)addNotification:(id)sender
{
    UILocalNotification *note =[[UILocalNotification alloc] init];
    note.alertBody = @"Notification 1";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    note.fireDate = date;
    badgeValue++;
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",badgeValue];
    note.soundName = @"notification.m4a";
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: badgeValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeInfo:(NSString*) name
{
    nTabs++;
    _numberTabs.text = [NSString stringWithFormat:@"%d",nTabs];
    
    startPosName++;
    
    tabNames.text = [tabNames.text stringByAppendingString:[NSString stringWithFormat:@" %@",name]];
    
}

@end
