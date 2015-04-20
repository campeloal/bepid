//
//  FotosView.m
//  DesafioFoto
//
//  Created by Alex De Souza Campelo Lima on 5/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "FotosView.h"

@implementation FotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) drawImage
{
    CGRect nameRect = CGRectMake(20,280,100,20);
    UILabel *name = [[UILabel alloc] initWithFrame:nameRect];
    NSString *finalName = @"Nome: ";
    finalName = [finalName stringByAppendingString: _name];
    name.text = finalName;
    [self addSubview:name];
    
    CGRect ageRect = CGRectMake(20,300,100,20);
    UILabel *age = [[UILabel alloc] initWithFrame:ageRect];
    NSString *finalAge = @"Idade: ";
    finalAge = [finalAge stringByAppendingString: _age];
    age.text = finalAge;
    [self addSubview:age];
    
    UIImage *img = [UIImage imageNamed:_image];
    CGRect imageRect = CGRectMake(self.frame.size.width/2 - img.size.width/2,100,img.size.width,img.size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    [imageView setFrame:imageRect];
    [self addSubview:imageView];
}

@end
