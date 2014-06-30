//
//  BPDReminderViewController.m
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BPDReminderViewController.h"

@interface BPDReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BPDReminderViewController

-(IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    UILocalNotification *note =[[UILocalNotification alloc] init];
    note.alertBody = @"Alert1";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    NSLog(@"Setting a reminder for %@", date);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        UIImage *image = [UIImage imageNamed:@"view2.png"];
        self.tabBarItem.image = [self imageWithImage: image scaledToSize:CGSizeMake(20, 20)];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BPDReminder carregou a view");
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
