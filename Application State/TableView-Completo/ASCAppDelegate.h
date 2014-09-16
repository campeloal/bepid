//
//  ASCAppDelegate.h
//  TableView-Completo
//
//  Created by Alex De Souza Campelo Lima on 7/15/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *numbers;

-(BOOL) saveChanges;
-(NSString*) itemArchivePath;

@end
