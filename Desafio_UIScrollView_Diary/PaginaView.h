//
//  PaginaView.h
//  DesafioDiario
//
//  Created by Alex on 5/22/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginaView : UIView

-(void) writeText: (NSString *) text InFrame: (CGRect) frame;
-(void) writeTopic:(NSString *)text InFrame:(CGRect)frame;

@end
