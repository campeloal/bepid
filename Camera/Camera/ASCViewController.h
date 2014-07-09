//
//  ASCViewController.h
//  Camera
//
//  Created by Alex De Souza Campelo Lima on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagem;
- (IBAction)takePicture:(id)sender;
- (IBAction)removePicture:(id)sender;


@end
