//
//  ViewController.h
//  iOSShaders
//
//  Created by Teste on 03/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "Object.h"

@interface ViewController : GLKViewController
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *numberPoly;
@property (weak, nonatomic) IBOutlet UIButton *decButton;
- (IBAction)addPolygons:(id)sender;
- (IBAction)decPolygons:(id)sender;

@end
