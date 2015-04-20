//
//  ClientViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientModel.h"
#import "Client.h"

#import "CarModel.h"

@interface ClientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthDatePicker;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (nonatomic) ClientCarViewController *ccvc;
@property (nonatomic) NSMutableArray *cars;

@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Adcionar Cliente";
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(saveClient:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    if (self.client) {
        _nameTextField.text = _client.name;
        _photoImageView.image = _client.photo;
        self.cars = [[NSMutableArray alloc] initWithArray:[_client.own allObjects]];
        [_client setThumbnailFromImage:_photoImageView.image];
    }
    else
    {
        self.cars = [[NSMutableArray alloc] init];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)saveClient:(id)sender
{
    
    if (!self.client) {
        ClientModel *clientModel = [ClientModel sharedModel];
        _client = [clientModel createClient];
    }

    _client.name = _nameTextField.text;
    _client.photo = _photoImageView.image;
    _client.own = [NSSet setWithArray:self.cars];
    [_client setThumbnailFromImage:_photoImageView.image];
    
    [[CarModel sharedModel] removeCars:self.cars fromCoreData:NO];
    
    if (self.ccvc) {
        
        [[CarModel sharedModel] removeCars:[CarModel sharedModel].allCars fromCoreData:NO];
        
        [[CarModel sharedModel] addCars:_ccvc.avaliable];
        
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.photoImageView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)carList:(id)sender {
    if (!self.ccvc) {
        self.ccvc = [[ClientCarViewController alloc] init];
        self.ccvc.acquired = self.cars;
    }
    
    NSLog(@"available2 %@", [CarModel sharedModel].allCars);
    
    [self.navigationController pushViewController:self.ccvc animated:YES];
}


- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}


@end
