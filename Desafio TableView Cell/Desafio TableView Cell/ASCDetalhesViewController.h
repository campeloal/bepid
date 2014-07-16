//
//  ASCDetalhesViewController.h
//  Desafio TableView Cell
//
//  Created by Alex De Souza Campelo Lima on 7/16/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCDetalhesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *primeiroNome;
@property (weak, nonatomic) IBOutlet UILabel *segundoNome;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (strong, nonatomic) NSString *primeiroNomeText;
@property (strong, nonatomic) NSString *segundoNomeText;
@property (strong, nonatomic) NSString *imagemText;

@end
