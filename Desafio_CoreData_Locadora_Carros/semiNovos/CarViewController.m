//
//  CarViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/30/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "CarViewController.h"
#import "CarModel.h"
#import "Car.h"
#import "BrandModel.h"
#import "Brand.h"
#import "CarsCollectionViewController.h"
#import "Photo.h"
#import "PhotoModel.h"

@interface CarViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *brandPicker;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *manufactureYearTextField;
@property (nonatomic) NSMutableArray *carPhotos;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Adicionar Carro";
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(saveCar:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    if (self.car) {
        _modelTextField.text = _car.model;
        _colorTextField.text = _car.color;
        _modelYearTextField.text = _car.modelYear;
        _manufactureYearTextField.text = _car.manufacteredYear;
        _carPhotos = [[NSMutableArray alloc] initWithArray:[_car.hasPhotos allObjects]];
    }
    else
    {
        _carPhotos = [[NSMutableArray alloc] init];
    }
    
}

- (void)saveCar:(id)sender
{
    if (!self.car) {
        CarModel *carModel = [CarModel sharedModel];
        
        _car = [carModel createCar];
    }
    
    _car.model = _modelTextField.text;
    _car.color = _colorTextField.text;
    _car.modelYear = _modelYearTextField.text;
    _car.manufacteredYear = _manufactureYearTextField.text;
    _car.hasPhotos = [NSSet setWithArray:_carPhotos];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    BrandModel *brandModel = [BrandModel sharedModel];
    return [brandModel.allBrands count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    BrandModel *brandModel = [BrandModel sharedModel];
    Brand *brand = [brandModel.allBrands objectAtIndex:row];

    return brand.brand;
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
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

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    PhotoModel *photoModel = [PhotoModel sharedModel];
    
    Photo *photo = [photoModel createPhoto];
    photo.photo = image;
    
    
    [_carPhotos addObject: photo];
    
    CarsCollectionViewController *carsCollec = [[CarsCollectionViewController alloc] init];
    
    carsCollec.carPhotos = _carPhotos;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController pushViewController:carsCollec animated:YES];
    
}

- (IBAction) showCollection:(id)sender {
    
    CarsCollectionViewController *carsCollec = [[CarsCollectionViewController alloc] init];
    carsCollec.carPhotos = _carPhotos;
    
    [self.navigationController pushViewController:carsCollec animated:YES];

}

@end
