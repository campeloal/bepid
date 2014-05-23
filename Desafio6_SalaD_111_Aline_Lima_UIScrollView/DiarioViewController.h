//
//  DiarioViewController.h
//  DesafioDiario
//
//  Created by Alex on 5/22/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaginaView.h"

@interface DiarioViewController : UIViewController
{
    CGRect windowSize;
}

- (id)initWithWindowSize: (CGRect) size;
@end
