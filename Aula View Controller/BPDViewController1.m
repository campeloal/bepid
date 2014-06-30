//
//  BPDViewController1.m
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "BPDViewController1.h"
#import "BPDView1.h"

@implementation BPDViewController1

-(void) loadView
{
    BPDView1 *firstView = [[BPDView1 alloc] init];
    firstView.backgroundColor = [UIColor redColor];
    
    self.view = firstView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"View1";
        UIImage *image = [UIImage imageNamed:@"view1.png"];
        self.tabBarItem.image = [self imageWithImage: image scaledToSize:CGSizeMake(20, 20)];
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BPDViewController1 carregou a view");
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
