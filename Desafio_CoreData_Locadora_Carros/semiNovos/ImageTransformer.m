//
//  ImageTransformer.m
//  semiNovos
//
//  Created by Alex De Souza Campelo Lima on 10/3/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "ImageTransformer.h"

@implementation ImageTransformer

+(Class) transformedValueClass
{
    return [NSData class];
}

-(id) transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

-(id) reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
