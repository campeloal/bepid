//
//  Client.m
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/3/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "Client.h"


@implementation Client

@dynamic birthDate;
@dynamic name;
@dynamic photo;
@dynamic thumbnail;
@dynamic own;

-(void) setThumbnailFromImage:(UIImage *)image
{
    CGRect newRect = CGRectMake(0, 0, 70, 70);
    
    float ratio = MAX(newRect.size.height / image.size.height,
                      newRect.size.width / image.size.width);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect
                                                    cornerRadius:10];
    
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * image.size.width;
    projectRect.size.height = ratio * image.size.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    UIGraphicsEndImageContext();
}

@end
