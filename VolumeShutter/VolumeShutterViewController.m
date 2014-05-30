//
//  VolumeShutterViewController.m
//  VolumeShutter
//
//  Created by Alex De Souza Campelo Lima on 5/27/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "VolumeShutterViewController.h"

@interface VolumeShutterViewController ()

@end

@implementation VolumeShutterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session addObserver:self
              forKeyPath:@"outputVolume"
                 options:0
                 context:nil];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqual:@"outputVolume"]) {
        NSLog(@"volume changed!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
