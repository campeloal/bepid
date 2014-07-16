//
//  ASCCustomTableViewCell.h
//  Desafio TableView Cell
//
//  Created by Alex De Souza Campelo Lima on 7/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customPrimeiroNome;
@property (weak, nonatomic) IBOutlet UILabel *customSegundoNome;
@property (weak, nonatomic) IBOutlet UIImageView *customImagem;

@end
