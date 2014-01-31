//
//  ConfiguracionViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/7/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "ConfiguracionViewController.h"
#import "PortadaIniViewController.h"
#import "SwitchConfiguracionCell.h"
#import "OptionsConfiguracionCell.h"
#import "BackgroundConfigurationCells.h"
#import "BackgroundConfiguration.h"
#import "BackgroundConfigurationCellFirst.h"
#import "BackgroundConfigurationSelectCell.h"
#import "BackgroundConfigurationSelectFirstCell.h"

#import "BackgroundConfigurationWhiteView.h"

#import "MicuentaViewController.h"

#import "PromocionesViewController.h"

#import "AFNetworking.h"
#import "DejalActivityView.h"
#import "AppUrl.h"



@interface ConfiguracionViewController ()

@end

@implementation ConfiguracionViewController

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
    [[PortadaIniViewController sharedInstance] toolBarSetup:self];
    
    // NavigationBar
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [title setText:@"Configuración"];
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
    
    
    [self.tableView setBackgroundView:[BackgroundConfigurationWhiteView new]];
    
    
    
    
    
    
    if ([AppUrl getIdUser]) {
        NSLog(@"%@", [AppUrl getIdUser]);
    } else {
        // Verificar si tiene cuenta, caso contrario mostramos la alerta
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Crear Cuenta" message:@"Usted necesita ingresar con su cuenta de usuario para acceder a Promociones" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancelar", @"Ingresar", nil];
        
        [alert show];
    }
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
}

- (void) btnDelivery:(UIButton*) sender {
    NSLog(@"boton delivery");
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
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        SwitchConfiguracionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell" forIndexPath:indexPath];
        
        if (indexPath.row!=0) {
            cell.backgroundView = [BackgroundConfigurationCells new];
            cell.selectedBackgroundView = [BackgroundConfigurationSelectCell new];
        } else {
            cell.backgroundView = [BackgroundConfigurationCellFirst new];
            cell.selectedBackgroundView = [BackgroundConfigurationSelectFirstCell new];
        }


        [cell.switchPush setBackgroundColor:[UIColor whiteColor]];
        [cell.switchPush setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [cell.switchPush setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
        [cell.switchPush setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        
        [cell.switchEmail setBackgroundColor:[UIColor whiteColor]];
        [cell.switchEmail setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [cell.switchEmail setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
        [cell.switchEmail setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        
        if (indexPath.row == 0) {
            cell.lblTitulo.text = @"Nuevas Promociones";
            
            self.btnPush1 = cell.switchPush;
            [cell.switchPush addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchPush.tag = 1;
            
            self.btnEmail1 = cell.switchEmail;
            [cell.switchEmail addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchEmail.tag = 2;
            
        } else if(indexPath.row==1){
            self.btnPush2 = cell.switchPush;
            cell.lblTitulo.text = @"Nuevas Promociones Personalizadas";
            [cell.switchPush addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchPush.tag = 3;
            
            self.btnEmail2 = cell.switchEmail;
            [cell.switchEmail addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchEmail.tag = 4;
        } else {
            cell.lblTitulo.text = @"Recordatorio de Pastillas";
            
            self.btnPush3 = cell.switchPush;
            [cell.switchPush addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchPush.tag = 5;
            
            self.btnEmail3 = cell.switchEmail;
            [cell.switchEmail addTarget:self action:@selector(btnPush:) forControlEvents:UIControlEventTouchUpInside];
            cell.switchEmail.tag = 6;
        }
        return cell;
        
    } else if(indexPath.section==1) {
        OptionsConfiguracionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionsCell" forIndexPath:indexPath];
        
        if (indexPath.row!=0) {
            cell.backgroundView = [BackgroundConfigurationCells new];
            cell.selectedBackgroundView = [BackgroundConfigurationSelectCell new];
        } else {
            cell.backgroundView = [BackgroundConfigurationCellFirst new];
            cell.selectedBackgroundView = [BackgroundConfigurationSelectFirstCell new];
        }
        
        if (indexPath.row == 0) {
            cell.lblTitutlo.text = @"Editar Perfil";
        } else if(indexPath.row==1){
            cell.lblTitutlo.text = @"Direcciones";
        } else {
            cell.lblTitutlo.text = @"Políticas de Privacidad";
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"closeCell" forIndexPath:indexPath];
        cell.backgroundView = [BackgroundConfigurationCellFirst new];
        cell.selectedBackgroundView = [BackgroundConfigurationSelectFirstCell new];
        
        return cell;
    }

}

// Click en optiones

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1 && indexPath.row == 0) { // Editar Perfil
        [self performSegueWithIdentifier:@"perfilSegue" sender:self];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) { // Direcciones
        [self performSegueWithIdentifier:@"SegueDirecciones" sender:self];
    }

    if (indexPath.section == 1 && indexPath.row == 2) { // Politicas de Privacidad
        //politicas de privacidad.
        
    }
    
    if (indexPath.section == 2) { // Cerrar Sessión
        [AppUrl closeSesion];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


// Buttons Switch Push and Email

- (void) btnPush :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
    } else {
        [sender setSelected:YES];
    }
    
    
    // ================== NUEVAS PROMOCIONES ==================
    // 1 --- PUSH
    if ([sender isSelected] && sender.tag == 1) {
        NSString *opt = @"";
        if ( [self.btnEmail1 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promosnews" withPushStatus:@"yes" withEmailStatus:opt];
    } else if (![sender isSelected] && sender.tag == 1) {
        NSString *opt = @"";
        if ( [self.btnEmail1 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promosnews" withPushStatus:@"no" withEmailStatus:opt];
    }
    
    // 2 --- EMAIL
    if ([sender isSelected] && sender.tag == 2) {
        NSString *opt = @"";
        if ( [self.btnPush1 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promosnews" withPushStatus:opt withEmailStatus:@"yes"];
    } else if (![sender isSelected] && sender.tag == 2) {
        NSString *opt = @"";
        if ( [self.btnPush1 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promosnews" withPushStatus:opt withEmailStatus:@"no"];
    }
    
    // ================== NUEVAS PROMOCIONES PERSONALIZADAS ==================
    
    // 3 --- PUSH
    if ([sender isSelected] && sender.tag == 3) {
        NSString *opt = @"";
        if ( [self.btnEmail2 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promoscustom" withPushStatus:@"yes" withEmailStatus:opt];
    } else if (![sender isSelected] && sender.tag == 3) {
        NSString *opt = @"";
        if ( [self.btnEmail2 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promoscustom" withPushStatus:@"no" withEmailStatus:opt];
    }

    // 4 --- EMAIL
    if ([sender isSelected] && sender.tag == 4) {
        NSString *opt = @"";
        if ( [self.btnPush2 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promoscustom" withPushStatus:opt withEmailStatus:@"yes"];
    } else if (![sender isSelected] && sender.tag == 4) {
        NSString *opt = @"";
        if ( [self.btnPush2 isSelected]) {
            opt = @"yes";
        } else {
            opt = @"no";
        }
        [self checkChangeStatus:@"promoscustom" withPushStatus:opt withEmailStatus:@"no"];
    }
    
    // ======================== RECORDATORIO DE PASTILLAS ========================

    // 5 --- PUSH
    if ([sender isSelected] && sender.tag == 5) {
        
    } else if (![sender isSelected] && sender.tag == 5) {
        
    }

    // 6 --- EMAIL
    if ([sender isSelected] && sender.tag == 6) {
        
    } else if (![sender isSelected] && sender.tag == 6) {
        
    }
    
    NSLog(@"%i", sender.tag);
}


- (void) btnEmail :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
    } else {
        [sender setSelected:YES];
    }
    
    // 1 --- promoscustom
    if ([sender isSelected] && sender.tag == 1) {
        
    } else if (![sender isSelected] && sender.tag == 1) {
        
    }
    
    // 2 --- promosnews
    if ([sender isSelected] && sender.tag == 2) {
        
    } else if (![sender isSelected] && sender.tag == 2) {
        
    }
    
    // 3 --- reminder
    if ([sender isSelected] && sender.tag == 3) {
        //[self checkChangeStatus:@"reminder" withPushStatus:@"" withEmailStatus:@""];
    } else if (![sender isSelected] && sender.tag == 3) {
        
    }
    
    NSLog(@"%i", sender.tag);
}



- (void) checkChangeStatus : (NSString *) tipoStatus withPushStatus:(NSString *) pushStatus withEmailStatus : (NSString *) emailStatus{

    [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Actualizando"];
    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    
    //Carga de data
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [AppUrl getApiKey], @"apikey",
                            [AppUrl getIdUser], @"n_user_config",
                            tipoStatus, @"c_type_config",
                            pushStatus, @"c_statustype_config",
                            emailStatus, @"c_statusemail_config",
                            nil];
    
    NSLog(@"%@", params);
    
    AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getUpdateConfig]];
    [request postPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@", result);
        
        if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
            
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
    
    
    
    
}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Notificaciones";
    } else {
        return @"";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 44;
    }
}





#pragma mark -
#pragma mark UIAlerView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //Cargamos formulario de Mi Cuenta
        MicuentaViewController *l = [self.storyboard instantiateViewControllerWithIdentifier:@"miCuentaView"];
        [self presentViewController:l animated:YES completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        
    }
}

@end
