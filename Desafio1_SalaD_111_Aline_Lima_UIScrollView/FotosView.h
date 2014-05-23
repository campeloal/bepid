//
//  FotosView.h
//  DesafioFoto
//
//  Created by Alex De Souza Campelo Lima on 5/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FotosView : UIView

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, retain) NSString* image;

-(void) drawImage;
@end
