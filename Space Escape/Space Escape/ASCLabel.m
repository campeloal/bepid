//
//  ASCLabel.m
//  Space Escape
//
//  Created by Alex De Souza Campelo Lima on 10/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCLabel.h"
#import "ASCGameState.h"

@implementation ASCLabel

-(instancetype) initWithFontNamed:(NSString *)fontName
{
    self = [super initWithFontNamed:fontName];
    
    if (self) {
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        self.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    }
    
    return self;
}

-(void) update
{
    self.text = [NSString stringWithFormat:@"%lu",(unsigned long) [ASCGameState sharedState].score];
}

@end
