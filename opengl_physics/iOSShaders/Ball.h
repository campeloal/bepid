//
//  Ball.h
//  iOSShaders
//
//  Created by Alex De Souza Campelo Lima on 9/24/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PObject.h"
#import "RObject.h"

@interface Ball : NSObject

@property (nonatomic) PObject *physhics;
@property (nonatomic) RObject *render;

@end
