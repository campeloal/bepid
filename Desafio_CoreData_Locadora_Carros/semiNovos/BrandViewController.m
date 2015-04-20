//
//  BrandViewController.m
//  semiNovos
//
//  Created by Phelippe Augusto de Amorim on 9/29/14.
//  Copyright (c) 2014 Phelippe Augusto de Amorim. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandModel.h"
#import "Brand.h"

@interface BrandViewController ()

@property (weak, nonatomic) IBOutlet UITextField *descricaoField;

@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Adcionar Marca";
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                           target:self
                                                                           action:@selector(saveBrand:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    if (self.brand) {
        _descricaoField.text = _brand.brand;
    }
}

- (void)saveBrand:(id)sender
{
    if (!self.brand) {
        BrandModel *brandModel = [BrandModel sharedModel];
        
        _brand = [brandModel createBrand];
    }

    _brand.brand = _descricaoField.text;

    [self.navigationController popViewControllerAnimated:YES];
}

@end
