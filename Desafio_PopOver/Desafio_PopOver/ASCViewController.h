//
//  ASCViewController.h
//  Desafio_PopOver
//
//  Created by Alex De Souza Campelo Lima on 8/12/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIPopoverController *imagePickerPopover;
- (IBAction)takePicture:(id)sender;

@end
