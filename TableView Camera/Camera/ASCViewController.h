//
//  ASCViewController.h
//  Camera
//
//  Created by Alex De Souza Campelo Lima on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendData <NSObject>

-(void) sendName:(NSString*) photoName Image: (UIImageView*) image;

@end

@interface ASCViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) IBOutlet UITextField *photoName;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (nonatomic, assign) id delegate;
- (IBAction)takePicture:(id)sender;
- (IBAction)removePicture:(id)sender;
-(IBAction) dismissKeyboard;


@end
