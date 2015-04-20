//
//  ASCMainScreenViewController.m
//  Web_Service_Exemplo
//
//  Created by Alex De Souza Campelo Lima on 9/22/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCMainScreenViewController.h"

@interface ASCMainScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainScreenLabel;

@end

@implementation ASCMainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"main_screen", nil);
    
    
    UINavigationItem *navEditItem = self.navigationItem;
    
    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style: UIBarButtonItemStylePlain target:self action:@selector(pushUpload:)];
    
    navEditItem.rightBarButtonItem = uploadButton;
    
    UIBarButtonItem *pickButton = [[UIBarButtonItem alloc] initWithTitle:@"Pick" style: UIBarButtonItemStylePlain target:self action:@selector(pushPick:)];
    
    navEditItem.leftBarButtonItem = pickButton;
    
}

- (IBAction)pushPick:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.lblProcessado.text = @"";
    
    self.lblProcessado.hidden = TRUE;
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.lblProcessado.text = @"";
    
    self.lblProcessado.hidden = TRUE;
}

-(IBAction)pushUpload:(id)sender
{
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 90);
    
    imageData = [self compressImage:_imageView.image MaxSize: 10 Compression:0.9];
    
    NSString* urlString = @"http://172.16.1.52:8888/upload.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"--------------------------14737809831466499882746641449";
    
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n"
                      dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSHTTPURLResponse *response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"answer: %@",returnString);
    
    //NSLog(@"%@",response);
    
    self.lblProcessado.text = NSLocalizedString(@"image_sent", nil);
    
    self.lblProcessado.hidden = FALSE;
}

-(NSData*) compressImage: (UIImage*) image MaxSize: (int) maxFileSize Compression: (int) compression
{
    int maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}

@end
