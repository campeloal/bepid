//
//  ASCMainScreenViewController.h
//  Web_Service_Exemplo
//
//  Created by Alex De Souza Campelo Lima on 9/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCMainScreenViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UILabel *lblProcessado;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic)__weak IBOutlet UILabel *lblProcessado;

-(IBAction)pushPick:(id)sender;
-(IBAction)pushUpload:(id)sender;

@end
