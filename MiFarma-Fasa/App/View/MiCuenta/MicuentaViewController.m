//
//  MicuentaViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "MicuentaViewController.h"
#import "PortadaIniViewController.h"

#import "Item1LoginCell.h"
#import "Item2LoginCell.h"
#import "Item3LoginCell.h"

#import "BackgroundConfigurationWhiteView.h"

#import "BackgroundTipo1PerfilCell.h"
#import "BackgroundTipo2PerfilCell.h"
#import "BackgroundTipo3PerfilCell.h"

#import "BotonMiCuentaView.h"

#import "AFNetworking.h"
#import "AppUrl.h"

#import "DejalActivityView.h"

@interface MicuentaViewController ()

@end

@implementation MicuentaViewController

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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    [title setText:@"Iniciar Sesión"];
    [title setTextColor:[UIColor grayColor]];
    [title setBackgroundColor:[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:title];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma7.jpg"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma6.jpg"] forBarMetrics:UIBarMetricsDefault];
    }
    

    //Close Button ------------
    UIImage *image2 = [UIImage imageNamed:@"x.jpg"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:image2 forState:UIControlStateNormal];
    [button2 setImage:image2 forState:UIControlStateHighlighted];
    button2.frame = CGRectMake(0.0, 0.0, image2.size.width+10, image2.size.height);
    [button2 addTarget:self action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    self.btnHome.customView = button2;
    // ------------------------------

    
    self.tableView.backgroundView = [BackgroundConfigurationWhiteView new];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    

    
}


-(void) btnHome :(UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            Item1LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item1Cell" forIndexPath:indexPath];

            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            
            cell.backgroundView = [BackgroundTipo1PerfilCell new];
            cell.lblTitulo.text = @"E-mail";

            self.txtEmail = cell.txtTexto;
            self.txtEmail.delegate = self;
            
            return cell;
        } else if (indexPath.row == 1) {
            Item1LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item1Cell" forIndexPath:indexPath];

            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];

            cell.backgroundView = [BackgroundTipo3PerfilCell new];
            cell.lblTitulo.text = @"Contraseña";
            
            self.txtPass = cell.txtTexto;
            self.txtPass.delegate = self;
            
            return cell;
        } else {
            Item2LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item2Cell" forIndexPath:indexPath];
            
            [cell.lblTitulo setTextColor:[UIColor colorWithRed:45.0/255 green:60.0/255 blue:145.0/255 alpha:1]];
            
            cell.backgroundView = [BackgroundConfigurationWhiteView new];
            cell.lblTitulo.text = @"¿Olvidaste tu contraseña?";
            
            return cell;
        }
        
    } else if (indexPath.section == 1){
        Item3LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item3Cell" forIndexPath:indexPath];
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        cell.backgroundView = [BotonMiCuentaView new];
        cell.selectedBackgroundView = [BotonMiCuentaView new];        
        cell.lblTitulo.text = @"Iniciar Sesión";
        return cell;
    } else {
        
        Item3LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item3Cell" forIndexPath:indexPath];

        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        cell.backgroundView = [BotonMiCuentaView new];
        cell.selectedBackgroundView = [BotonMiCuentaView new];
        cell.lblTitulo.text = @"Crear una cuenta";
        
        return cell;    
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self  performSegueWithIdentifier:@"SegueRecuperarContrasena" sender:self];
    }
    
    if (indexPath.section == 2) {
        [self  performSegueWithIdentifier:@"SegueNuevaCuenta" sender:self];
    }
    
    if ( indexPath.section == 1 ) {
        
        if (![self.txtEmail.text length]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Iniciar Sesion" message:@"Debe ingresar un Email" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            
            [alert show];
        } else if (![self.txtPass.text length]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Iniciar Sesion" message:@"Debe ingresar un Password" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            
            [alert show];
        } else {
        
            
            [self.txtEmail resignFirstResponder];
            [self.txtPass resignFirstResponder];
            
            // ------------------------ LOGIN -----------------------------------
            
            [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Enviando datos"];
            [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
            
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [AppUrl getApiKey], @"apikey",
                                    self.txtEmail.text, @"c_email_user",
                                    self.txtPass.text, @"c_pass_user",
                                    nil];
            
            AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getLoginUser]];
            [request postPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                //NSLog(@"%@", result);
                //NSLog(@"status: %@", [result objectForKey:@"status"]);
                //NSLog(@"result: %@", [result objectForKey:@"user"]);
                
                if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
                    
                    [DejalBezelActivityView removeViewAnimated:YES];
                    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                    
                    [AppUrl setIdUser:[[result objectForKey:@"user"] objectForKey:@"n_id_user"]];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [DejalBezelActivityView removeViewAnimated:YES];
                    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email o Contraseña incorrecta" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                    [alert show];
                }
            }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                NSLog(@"%@",error.localizedFailureReason);
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de Servidor" message:@"Error de conección, intente mas tarde." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                [alert show];
            }];
            // ------------------------ LOGIN -----------------------------------

            
            
            
            
            
        }
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 5;
    } else {
        return 20;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}




@end
