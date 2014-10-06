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

@interface CarViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *brandPicker;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *manufactureYearTextField;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Adcionar Carro";
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(saveCar:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    if (self.car) {
        _modelTextField.text = _car.model;
        _colorTextField.text = _car.color;
        _modelYearTextField.text = _car.modelYear;
        _manufactureYearTextField.text = _car.manufacteredYear;
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

@end
