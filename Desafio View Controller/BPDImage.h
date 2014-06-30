//
//  BPDImage.h
//  Aula View Controller
//
//  Created by Alex De Souza Campelo Lima on 6/30/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPDImage : NSObject

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
