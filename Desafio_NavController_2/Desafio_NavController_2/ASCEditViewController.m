//
//  ASCEditViewController.m
//  Desafio_NavController_2
//
//  Created by Alex De Souza Campelo Lima on 7/9/14.
//  Copyright (c) 2014 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ASCEditViewController.h"
#import "ASCAlugarCarroViewController.h"
#import "ASCCarCollection.h"

@interface ASCEditViewController ()
{
    UIButton *alugar, *oficina, *retorno;
    UILabel *dataInicio,*dataFim,*dias,*diasValue,*statusValue;
}

@end

@implementation ASCEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) viewWillAppear:(BOOL)animated
{
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    name.text = [NSString stringWithFormat:@"%@%@", @"Nome: ", [[ASCCarCollection sharedCarCollection] obterNomeIndex:_currentCar]];
    [self.view addSubview:name];
    
    UILabel *placa = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
    placa.text = [NSString stringWithFormat:@"%@%@", @"Placa: ", [[ASCCarCollection sharedCarCollection] obterPlacaIndex:_currentCar]];
    [self.view addSubview:placa];
    
    UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 40)];
    status.text = @"Status: ";
    [self.view addSubview:status];
    
    statusValue = [[UILabel alloc] initWithFrame:CGRectMake(110, 200, 200, 40)];
    statusValue.text = [[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar];
    statusValue.tag = 1;
    [self.view addSubview:statusValue];
    [self checkStatusColor:_currentCar Label:statusValue];
    
    dias = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200, 40)];
    dias.text = @"Dias: ";
    
    diasValue = [[UILabel alloc] initWithFrame:CGRectMake(240, 200, 30, 40)];
    diasValue.text = [NSString stringWithFormat:@"%d",[[ASCCarCollection sharedCarCollection] obterDias:_currentCar] ];
    
    [self.view addSubview:dias];
    [self.view addSubview:diasValue];
    
    [self checkDias:_currentCar Status:status Dias:diasValue];
    
    UILabel *modelo = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 40)];
    modelo.text = [NSString stringWithFormat:@"%@%@", @"Modelo: ", [[ASCCarCollection sharedCarCollection] obterModeloIndex:_currentCar]];
    [self.view addSubview:modelo];
    
    dataInicio = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 200, 40)];
    dataInicio.text = [NSString stringWithFormat:@"%@%@", @"Data Início: ", [[ASCCarCollection sharedCarCollection] obterDataInicioIndex:_currentCar]];
    [self.view addSubview:dataInicio];
    
    dataFim = [[UILabel alloc] initWithFrame:CGRectMake(50, 350, 200, 40)];
    dataFim.text = [NSString stringWithFormat:@"%@%@", @"Data Fim: ",[[ASCCarCollection sharedCarCollection] obterDataFimIndex:_currentCar]];
    [self.view addSubview:dataFim];
    
    UILabel *valor = [[UILabel alloc] initWithFrame:CGRectMake(50, 400, 200, 40)];
    valor.text = [NSString stringWithFormat:@"%@%@", @"Valor: ", [[ASCCarCollection sharedCarCollection] obterValorIndex:_currentCar]];
    [self.view addSubview:valor];
    
    [self showButtons];
}



-(void) checkDias: (int) index Status: (UILabel*) label Dias: (UILabel*) diasLabel
{
    if (([[ASCCarCollection sharedCarCollection] obterDias:index] > 30) && ([label.text isEqualToString:@"Disponível"])) {
        diasLabel.backgroundColor = [UIColor blueColor];
    }
}

-(void) checkStatusColor: (int) index Label: (UILabel*) label
{
    if([[[ASCCarCollection sharedCarCollection] obterStatusIndex:index] isEqualToString:@"Alugado"])
    {
        label.textColor = [UIColor redColor];
    }
    else if ([[[ASCCarCollection sharedCarCollection] obterStatusIndex:index] isEqualToString:@"Disponível"])
    {
        label.textColor = [UIColor greenColor];
    }
    else
    {
        label.textColor = [UIColor orangeColor];
    }
}

-(void) addRentButton
{
    alugar = [[UIButton alloc] initWithFrame:CGRectMake(0, 440, 100, 40)];
    alugar.tag = 2;
    [alugar setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    [alugar setTitle:@"Alugar" forState:UIControlStateNormal];
    [alugar sendActionsForControlEvents:UIControlEventTouchUpInside];
    [alugar setBackgroundColor:[UIColor grayColor]];
    [alugar addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
    alugar.showsTouchWhenHighlighted = YES;
    
    [self.view addSubview:alugar];
}

-(void) addReturnButton
{
    retorno = [[UIButton alloc] initWithFrame:CGRectMake(0, 440, 100, 40)];
    retorno.tag = 3;
    [retorno setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    [retorno setTitle:@"Retorno" forState:UIControlStateNormal];
    [retorno sendActionsForControlEvents:UIControlEventTouchUpInside];
    [retorno setBackgroundColor:[UIColor grayColor]];
    [retorno addTarget:self action:@selector(return:) forControlEvents:UIControlEventTouchUpInside];
    retorno.showsTouchWhenHighlighted = YES;
}

-(void) showButtons
{
    
    if([[[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar] isEqualToString:@"Disponível"])
    {
        
        [self addRentButton];
        
    }
    else if(([[[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar] isEqualToString:@"Alugado"]) || ([[[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar] isEqualToString:@"Oficina"]))
    {
        [self addReturnButton];
        
        UIView *status = [self.view viewWithTag:1];
        [status removeFromSuperview];
        UILabel *newStatus = [[UILabel alloc] initWithFrame:CGRectMake(110, 200, 200, 40)];
        newStatus.tag = 1;
        newStatus.text = @"Alugado";
        
        [self.view addSubview:retorno];
    }
    
    if (([[[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar] isEqualToString:@"Alugado"]) || ([[[ASCCarCollection sharedCarCollection] obterStatusIndex:_currentCar] isEqualToString:@"Disponível"]))
    {
        
        oficina = [[UIButton alloc] initWithFrame:CGRectMake(150, 440, 100, 40)];
        [oficina setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
        [oficina setTitle:@"Oficina" forState:UIControlStateNormal];
        [oficina sendActionsForControlEvents:UIControlEventTouchUpInside];
        [oficina setBackgroundColor:[UIColor grayColor]];
        [oficina addTarget:self action:@selector(oficina:) forControlEvents:UIControlEventTouchUpInside];
        oficina.showsTouchWhenHighlighted = YES;
        
        [self.view addSubview:oficina];
    }
    
}

- (IBAction)rent:(id)sender
{
    ASCAlugarCarroViewController *alVC = [[ASCAlugarCarroViewController alloc] init];
    alVC.currentCar = _currentCar;
    [self.navigationController pushViewController:alVC animated:YES];
}

- (IBAction)return:(id)sender
{
    [[ASCCarCollection sharedCarCollection] setStatus:@"Disponível" Index:_currentCar];
    UIView *status = [self.view viewWithTag:1];
    [status removeFromSuperview];
    
    UILabel *newStatus = [[UILabel alloc] initWithFrame:CGRectMake(110, 200, 200, 40)];
    newStatus.tag = 1;
    newStatus.text = @"Disponível";
    newStatus.textColor = [UIColor greenColor];
    [self.view addSubview: newStatus];
    
    UIView *returnButton = [self.view viewWithTag:3];
    [returnButton removeFromSuperview];
    [self addRentButton];
    
    [[ASCCarCollection sharedCarCollection] setDataInicio:@"" Index:_currentCar];
    
    dataInicio.text = @"Data Início: ";
    
    [[ASCCarCollection sharedCarCollection] setDataFim:@"" Index:_currentCar];
    dataFim.text = @"Data Fim: ";
    
}

- (IBAction)oficina:(id)sender
{
    [[ASCCarCollection sharedCarCollection] setStatus:@"Oficina" Index:_currentCar];
    UIView *status = [self.view viewWithTag:1];
    [status removeFromSuperview];
    
    UILabel *newStatus = [[UILabel alloc] initWithFrame:CGRectMake(110, 200, 200, 40)];
    newStatus.tag = 1;
    newStatus.text = @"Oficina";
    newStatus.textColor = [UIColor orangeColor];
    [self.view addSubview: newStatus];
    
    [[ASCCarCollection sharedCarCollection] setDataInicio:@"" Index:_currentCar];
    
    dataInicio.text = @"Data Início: ";
    
    [[ASCCarCollection sharedCarCollection] setDataFim:@"" Index:_currentCar];
    dataFim.text = @"Data Fim: ";
    
    [self checkDias:_currentCar Status:statusValue Dias:diasValue];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
