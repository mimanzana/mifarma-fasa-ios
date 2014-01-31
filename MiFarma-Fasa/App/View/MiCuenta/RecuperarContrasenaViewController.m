//
//  RecuperarContrasenaViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/14/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "RecuperarContrasenaViewController.h"
#import "PortadaIniViewController.h"

#import "Item1ForgotPassCell.h"
#import "Item2ForgotPassCell.h"
#import "Item3ForgotPassCell.h"

#import "BackgroundConfigurationWhiteView.h"

#import "BackgroundTipo1PerfilCell.h"
#import "BackgroundTipo2PerfilCell.h"
#import "BackgroundTipo3PerfilCell.h"
#import "BackgroundTipo4PerfilCell.h"

#import "BotonMiCuentaView.h"


@interface RecuperarContrasenaViewController ()

@end

@implementation RecuperarContrasenaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // NavigationBar
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    [title setText:@"Recuperar Contraseña"];
    [title setTextColor:[UIColor grayColor]];
    [title setBackgroundColor:[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:title];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma7.jpg"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma6.jpg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    //ToolBar Buttons ------------
    UIButton *back = [[PortadaIniViewController sharedInstance] getBackButton];
    [back addTarget:self action:@selector(btnRetroceder:) forControlEvents:UIControlEventTouchUpInside];
    self.btnBack.customView = back;
    
    UIButton *home = [[PortadaIniViewController sharedInstance] getHomeButton];
    [home addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    self.btnHome.customView = home;
    // ------------------------------
    
    
    self.tableView.backgroundView = [BackgroundConfigurationWhiteView new];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

// --- Buttons ToolBar -----
- (void) btnRetroceder: (UIButton *) sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) btnHome :(UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// -------------------------






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        Item1ForgotPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.backgroundView = [BackgroundConfigurationWhiteView new];
        
        return cell;
    } else if (indexPath.section == 1) {
        Item2ForgotPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        cell.backgroundView = [BackgroundTipo4PerfilCell new];
        self.txtEmail = cell.txtTexto;
        self.txtEmail.text = @"";
        self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
        
        
        return cell;
    } else {
        Item3ForgotPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        cell.backgroundView = [BotonMiCuentaView new];
        cell.selectedBackgroundView =[BotonMiCuentaView new];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2) {
        
        if ([self.txtEmail.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debe ingresar un E-mail" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            NSLog(@"Enviando Contraseña");
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 86;
    } else {
        return 44;
    }
}



@end
