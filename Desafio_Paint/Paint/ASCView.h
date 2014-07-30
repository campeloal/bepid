//
//  ASCView.h
//  Paint
//
//  Created by Alex De Souza Campelo Lima on 7/29/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCView : UIView

@property (nonatomic) NSMutableArray *finishedShapes;
@property (nonatomic) NSMutableArray *shapesProperties;
@property (nonatomic) NSString* path;

-(NSString*) getPath;

@end
