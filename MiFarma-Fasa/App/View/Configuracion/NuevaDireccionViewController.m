//
//  NuevaDireccionViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "NuevaDireccionViewController.h"
#import "PortadaIniViewController.h"

#import "BackgroundConfiguration.h"

#import "ItemNuevaDireccionCell.h"
#import "GuardarDireccionCell.h"

#import "BackgroundTipo1PerfilCell.h"
#import "BackgroundTipo2PerfilCell.h"
#import "BackgroundTipo3PerfilCell.h"


#import "BackgroundConfigurationWhiteView.h"

#import "CustomToolBarTextPerfil.h"
#import "ControlesToolBar.h"

#import "DejalActivityView.h"
#import "AFNetworking.h"
#import "AppUrl.h"



@interface NuevaDireccionViewController ()

@end

@implementation NuevaDireccionViewController

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
    [title setText:@"Nueva Dirección"];
    [title setTextColor:[UIColor grayColor]];
    [title setBackgroundColor:[UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:title];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma7.jpg"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barraploma6.jpg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    //Close Button ------------
    UIImage *image2 = [UIImage imageNamed:@"x.jpg"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];

    [button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [button2 setImage:image2 forState:UIControlStateNormal];
    [button2 setImage:image2 forState:UIControlStateHighlighted];
    button2.frame = CGRectMake(0.0, 0.0, image2.size.width, image2.size.height);
    [button2 addTarget:self action:@selector(btnSalir:) forControlEvents:UIControlEventTouchUpInside];
    self.btnClose.customView = button2;
    // ------------------------------
    
    [self.tableView setBackgroundView:[BackgroundConfigurationWhiteView new]];
    
    
    
    
    
    
}

- (void) btnSalir :(UIButton *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// --- Buttons ToolBar -----
- (void) btnRetroceder: (UIButton *) sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) btnMenu: (UIButton *) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// -------------------------

//Controles de ToolBar
- (void) btnHome:(UIButton*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) btnNotification:(UIButton*) sender {
    [self performSegueWithIdentifier:@"SegueNotificacion" sender:self];
}
- (void) btnConfig:(UIButton*) sender {
    [[ControlesToolBar sharedInstance] btnConfiguracion:self withSegue:@"SegueConfiguracion"];
}

- (void) btnDelivery:(UIButton*) sender {
    NSLog(@"boton delivery");
}

// -------------------


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 6;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ItemNuevaDireccionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        if (indexPath.row == 0) {
            cell.backgroundView = [BackgroundTipo1PerfilCell new];
            
            cell.lblTitulo.text = @"Alias";
            self.txtAlias = cell.txtTexto;
            self.txtAlias.delegate = self;
            self.txtAlias.returnKeyType = UIReturnKeyNext;
        } else if (indexPath.row == 1) {
            cell.backgroundView = [BackgroundTipo2PerfilCell new];
            cell.lblTitulo.text = @"Distrito";
            self.txtDistrito = cell.txtTexto;
            self.txtDistrito.delegate = self;
            self.txtDistrito.returnKeyType = UIReturnKeyNext;
        } else if (indexPath.row == 2) {
            cell.backgroundView = [BackgroundTipo2PerfilCell new];
            cell.lblTitulo.text = @"Via";
            self.txtVia = cell.txtTexto;
            self.txtVia.delegate = self;
            self.txtVia.returnKeyType = UIReturnKeyNext;
        } else if (indexPath.row == 3) {
            cell.backgroundView = [BackgroundTipo2PerfilCell new];
            cell.lblTitulo.text = @"Dirección";
            self.txtDireccion = cell.txtTexto;
            self.txtDireccion.delegate = self;
            self.txtDireccion.returnKeyType = UIReturnKeyNext;
        } else if (indexPath.row == 4) {
            cell.backgroundView = [BackgroundTipo2PerfilCell new];
            cell.lblTitulo.text = @"Nro";
            self.txtNro = cell.txtTexto;
            self.txtNro.delegate = self;
            self.txtNro.returnKeyType = UIReturnKeyNext;
        } else if (indexPath.row == 5) {
            cell.backgroundView = [BackgroundTipo3PerfilCell new];
            cell.lblTitulo.text = @"Referencia";
            self.txtReferencia = cell.txtTexto;
            self.txtReferencia.delegate = self;
            self.txtReferencia.returnKeyType = UIReturnKeyDone;
        }
        
        return cell;
        
    } else {
        GuardarDireccionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuardarCell" forIndexPath:indexPath];        
    
        cell.backgroundView = [BackgroundConfigurationWhiteView new];
        [cell.btnGuardar setContentMode:UIViewContentModeScaleAspectFit];
        [cell.btnGuardar setImage:[UIImage imageNamed:@"guardar_direccion.jpg"] forState:UIControlStateNormal];
        [cell.btnGuardar setImage:[UIImage imageNamed:@"guardar_direccion.jpg"] forState:UIControlStateSelected];
        [cell.btnGuardar setImage:[UIImage imageNamed:@"guardar_direccion.jpg"] forState:UIControlStateHighlighted];
        
        [cell.btnGuardar addTarget:self action:@selector(btnGuardar:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}


- (void) btnGuardar :(UIButton *) sender {
    
    if ( [self.txtAlias.text isEqualToString:@""] ||
         [self.txtDistrito.text isEqualToString:@""] ||
         [self.txtVia.text isEqualToString:@""] ||
         [self.txtDireccion.text isEqualToString:@""] ||
         [self.txtNro.text isEqualToString:@""] ||
         [self.txtReferencia.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debe de llenar todos los campos." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        
        // --- Código Aquí ---
        
        [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Guardando"];
        [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
        
        
        //Carga de data
        self.obj = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AppUrl getApiKey], @"apikey",
                                [AppUrl getIdUser], @"n_id_user",
                                self.txtAlias.text, @"c_alias_address",
                                self.txtDistrito.text, @"c_district_address",
                                self.txtVia.text, @"c_via_address",
                                self.txtDireccion.text, @"c_address_address",
                                self.txtNro.text, @"c_nro_address",
                                self.txtReferencia.text, @"c_reference_address",
                                nil];
        
        AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getCreateAddress]];
        [request postPath:nil parameters:self.obj success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"%@", result);
            
            if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                
                [self dismissViewControllerAnimated:YES completion:^{
                    [self.delegate listarDirecciones:self];
                }];
                
            } else {
                [DejalBezelActivityView removeViewAnimated:YES];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de Servidor" message:@"Se produjo un error, intente nuevamente." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                [alert show];
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"%@",error.localizedFailureReason);
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de Servidor" message:@"Error de conección, intente mas tarde." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
            [alert show];
        }];
        
        
        // ---------
    }
    

    
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark -
#pragma mark UITextField Delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtAlias) {
        [self.txtDistrito becomeFirstResponder];
    } else if (textField == self.txtDistrito) {
        [self.txtVia becomeFirstResponder];
    } else if (textField == self.txtVia) {
        [self.txtDireccion becomeFirstResponder];
    } else if (textField == self.txtDireccion) {
        [self.txtNro becomeFirstResponder];
    } else if (textField == self.txtNro) {
        [self.txtReferencia becomeFirstResponder];
    } else if (textField == self.txtReferencia) {
        [self.txtReferencia resignFirstResponder];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CustomToolBarTextPerfil *okView = [[CustomToolBarTextPerfil alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(250, 0, 80, 40)];
    [b setTitle:@"OK" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [b.titleLabel setFont:[UIFont fontWithName:@"Verdana" size:14]];
    [b setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [b setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [b addTarget:self action:@selector(btnOkView:) forControlEvents:UIControlEventTouchUpInside];
    [okView addSubview:b];
    [textField setInputAccessoryView:okView];
    
}

- (void) btnOkView:(UIButton *) sender {
    [self.txtAlias resignFirstResponder];
    [self.txtDistrito resignFirstResponder];
    [self.txtVia resignFirstResponder];
    [self.txtDireccion resignFirstResponder];
    [self.txtNro resignFirstResponder];
    [self.txtReferencia resignFirstResponder];
}





@end
