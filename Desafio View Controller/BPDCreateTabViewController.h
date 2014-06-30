//
//  BPDCreateTabViewController.h
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendData<NSObject>

-(void) changeInfo: (NSString*) name;

@end

@interface BPDCreateTabViewController : UIViewController

@property (nonatomic, assign) id delegate;

- (IBAction)createNewTab:(id)sender;

@end
