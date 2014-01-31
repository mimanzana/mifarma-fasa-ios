//
//  PerfilViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/8/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "PerfilViewController.h"
#import "PortadaIniViewController.h"
#import "BackgroundConfiguration.h"

#import "Text1ConfigurationCell.h"
#import "Text2ConfigurationCell.h"
#import "Options1ConfigurationCell.h"
#import "Options2ConfigurationCell.h"
#import "Options3ConfigurationCell.h"

#import "BackgroundTipo1PerfilCell.h"
#import "BackgroundTipo2PerfilCell.h"
#import "BackgroundTipo3PerfilCell.h"
#import "BackgroundTipo4PerfilCell.h"

#import "BackgroundConfigurationWhiteView.h"

#import "CustomToolBarTextPerfil.h"

#import "DejalActivityView.h"

#import "PromocionesViewController.h"
#import "ControlesToolBar.h"


#import "AppUrl.h"
#import "AFNetworking.h"



@interface PerfilViewController ()

@end

@implementation PerfilViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.enfermedadesActive = NO;
    self.hijosActive = NO;
    self.mayorPersonaActive = NO;
    self.casadoActive = NO;
    
    
    CGFloat alto = [[UIScreen mainScreen] bounds].size.height;
    
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
    
    
    if (alto > 567) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        } else {
            [self.lblTitle setCenter:CGPointMake(84, 23)];
            [self.btnGuardar setCenter:CGPointMake(272, 23)];
            [self.tableview setFrame:CGRectMake(0, 45, 320, 503)];
        }
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        } else {
            [self.lblTitle setCenter:CGPointMake(84, 23)];
            [self.btnGuardar setCenter:CGPointMake(272, 23)];
            [self.tableview setFrame:CGRectMake(0, 144, 320, 300)];
        }
    }
    
    [self.tableview setBackgroundView:[BackgroundConfigurationWhiteView new]];
    
    
    

    
    
    // ----------------- Carga de la data ---------------------
    
    [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Cargando datos"];
    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [AppUrl getIdUser], @"n_id_user",
                            nil];
    
    AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getDataUser]];
    [request postPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //NSIndexPath* ipath = [NSIndexPath indexPathForRow: 0 inSection: 4];
        //    [self.tableview scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
        //[self.tableview cellForRowAtIndexPath:ipath];
        
        NSLog(@"%@", result);
        NSLog(@"status: %@", [result objectForKey:@"status"]);
        NSLog(@"result: %@", [result objectForKey:@"user"]);
        
        if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
            
            self.txtNombres.text =[[result objectForKey:@"user"] objectForKey:@"c_name_user"];
            self.txtApellidos.text = [[result objectForKey:@"user"] objectForKey:@"c_lastname_user"];
            self.txtEmail.text = [[result objectForKey:@"user"] objectForKey:@"c_email_user"];
            
            self.txtEdad.text = [NSString stringWithFormat:@"%i", [[[result objectForKey:@"user"] objectForKey:@"n_age_user"] intValue]];
            
            self.txtDni.text = [[result objectForKey:@"user"] objectForKey:@"c_dni_user"];
            self.txtTelefono.text = [[result objectForKey:@"user"] objectForKey:@"c_phone_user"];
            
            // casado/soltero
            if ([[[result objectForKey:@"user"] objectForKey:@"c_ismarried_user"] isEqualToString:@"no"]) {
                self.optionCasado = 0;
            } else {
                self.optionCasado = 1;
            }
            
            if (self.optionCasado==1) {
                [self.btnCasado setSelected:YES];
                [self.btnSoltero setSelected:NO];
            } else {
                [self.btnCasado setSelected:NO];
                [self.btnSoltero setSelected:YES];
            }

            //Hijos
            self.optionHijos =   [[[result objectForKey:@"user"] objectForKey:@"n_nchildren_user"] intValue];
            if ( self.optionHijos == 0) {
                [self.btnSinHijos setSelected:YES];
                [self.btnMenorUnAno setSelected:NO];
                [self.btnMenorTresAno setSelected:NO];
                [self.btnMenorCincoAno setSelected:NO];
            } else if (self.optionHijos == 1) {
                [self.btnSinHijos setSelected:NO];
                [self.btnMenorUnAno setSelected:YES];
                [self.btnMenorTresAno setSelected:NO];
                [self.btnMenorCincoAno setSelected:NO];
            } else if (self.optionHijos == 2) {
                [self.btnSinHijos setSelected:NO];
                [self.btnMenorUnAno setSelected:NO];
                [self.btnMenorTresAno setSelected: YES];
                [self.btnMenorCincoAno setSelected:NO];
            } else if (self.optionHijos == 3) {
                [self.btnSinHijos setSelected:NO];
                [self.btnMenorUnAno setSelected:NO];
                [self.btnMenorTresAno setSelected:NO];
                [self.btnMenorCincoAno setSelected:YES];
            }
            
            //Hipertension
            self.optionHipertension = [[[result objectForKey:@"user"] objectForKey:@"n_hipertension_user"] intValue];
            
            //Gastritis
            self.optionGastritis = [[[result objectForKey:@"user"] objectForKey:@"n_gastritis_user"] intValue];
            
            //Diabetes
            self.optionDiabetes = [[[result objectForKey:@"user"] objectForKey:@"n_diabetes_user"] intValue];
            
            //Corazon
            self.optionCorazon = [[[result objectForKey:@"user"] objectForKey:@"n_corazon_user"] intValue];
            
            //Colesterol
            self.optionColesterol = [[[result objectForKey:@"user"] objectForKey:@"n_colesterol_user"] intValue];
            
            //Mayor de edad.
            if ([[[result objectForKey:@"user"] objectForKey:@"c_olderperson_user"] isEqualToString:@"no"]) {
                self.optionPersonaMayor = 1;
            } else {
                self.optionPersonaMayor = 0;
            }
            
            
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) btnDelivery:(UIButton*) sender {
    NSLog(@"boton delivery");
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row>-1 && indexPath.row<2) {
            Text1ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];

            if (indexPath.row == 0) {
                cell.backgroundView = [BackgroundTipo1PerfilCell new];
                cell.lblTitulo.text = @"Nombres";
                self.txtNombres = cell.txtTexto;
                self.txtNombres.delegate = self;
                [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            } else {
                cell.backgroundView = [BackgroundTipo2PerfilCell new];
                cell.lblTitulo.text = @"Apellidos";
                self.txtApellidos = cell.txtTexto;
                self.txtApellidos.delegate = self;
                [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            }
            return cell;
        } else {
            if (indexPath.row == 2) {
                Text2ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text2Cell" forIndexPath:indexPath];
                
                cell.backgroundView = [BackgroundTipo2PerfilCell new];
                
                cell.lblTitulo1.text = @"Edad";
                cell.lblTitulo2.text = @"DNI";
                [cell.lblTitulo1 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
                [cell.lblTitulo2 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
                
                self.txtEdad = cell.txtTexto1;
                self.txtEdad.delegate = self;
                self.txtEdad.keyboardType = UIKeyboardTypeNumberPad;
                
                self.txtDni = cell.txtTexto2;
                self.txtDni.delegate = self;
                self.txtDni.keyboardType = UIKeyboardTypeNumberPad;
                
                return cell;
            } else {
            
                Text1ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
                cell.backgroundView = [BackgroundTipo3PerfilCell new];
                cell.lblTitulo.text = @"Telefono";
                self.txtTelefono = cell.txtTexto;
                self.txtTelefono.delegate = self;
                [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
                
                return cell;
            }
            
        }
    } else if (indexPath.section == 1) {
        Text1ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.backgroundView = [BackgroundTipo1PerfilCell new];
            
            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            
            self.txtEmail = cell.txtTexto;
            self.txtEmail.delegate = self;
            cell.lblTitulo.text = @"Email";
            self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
            
        } else if(indexPath.row == 1) {
            cell.backgroundView = [BackgroundTipo2PerfilCell new];
            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            
            self.txtContrasena = cell.txtTexto;
            self.txtContrasena.delegate = self;
            [self.txtContrasena setSecureTextEntry:YES];
            cell.lblTitulo.text = @"Contraseña Actual";
            
        } else {
            cell.backgroundView = [BackgroundTipo3PerfilCell new];
            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            
            self.txtReContrasena = cell.txtTexto;
            self.txtReContrasena.delegate = self;
            cell.lblTitulo.text = @"Nueva Contraseña";
            [cell.lblTitulo setFrame:CGRectMake(20, 12, 181, 21 )];
            [self.txtReContrasena setFrame:CGRectMake(200, 8, 80, 30)];
            [self.txtReContrasena setSecureTextEntry:YES];
        }
        return cell;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            Options1ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"options1Cell" forIndexPath:indexPath];
            
            [cell.lblTitulo1 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            [cell.lblTitulo2 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            
            
            cell.backgroundView = [BackgroundTipo1PerfilCell new];
            self.btnCasado = cell.btnCheck1;
            self.btnSoltero = cell.btnCheck2;
            
            [self setOptionCasadoSoltero:self.btnCasado withValue:1];
            [self setOptionCasadoSoltero:self.btnSoltero withValue:2];
            
            if (!self.casadoActive) {
                if (self.optionCasado==1) {
                    [self.btnCasado setSelected:YES];
                    [self.btnSoltero setSelected:NO];
                } else {
                    [self.btnCasado setSelected:NO];
                    [self.btnSoltero setSelected:YES];
                }
            }
            self.optionCasado = YES;
            
            
            return cell;
        } else {
            Options2ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"options2Cell" forIndexPath:indexPath];
            
            cell.backgroundView = [BackgroundTipo3PerfilCell new];
            
            [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];

            [cell.lblOption1 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            [cell.lblOption2 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            [cell.lblOption3 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            [cell.lblOption4 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
            [cell.lblOption5 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];

            cell.lblTitulo.text = @"Hijos:";
            cell.lblOption1.text = @"Sin hijos";
            cell.lblOption2.text = @"menor de 1 años";
            cell.lblOption3.text = @"menor de 3 años";
            cell.lblOption4.text = @"menor de 5 años";
            
            self.btnSinHijos      = cell.btnCheck1;
            self.btnMenorUnAno    = cell.btnCheck2;
            self.btnMenorTresAno  = cell.btnCheck3;
            self.btnMenorCincoAno = cell.btnCheck4;
            
            [self setOptionHijos:self.btnSinHijos withValue:1];
            [self setOptionHijos:self.btnMenorUnAno withValue:2];
            [self setOptionHijos:self.btnMenorTresAno withValue:3];
            [self setOptionHijos:self.btnMenorCincoAno withValue:4];
            
            NSLog(@"%i mas nada", self.optionHijos);
            
            if (!self.hijosActive) {
                if ( self.optionHijos == 0) {
                    [self.btnSinHijos setSelected:YES];
                    [self.btnMenorUnAno setSelected:NO];
                    [self.btnMenorTresAno setSelected:NO];
                    [self.btnMenorCincoAno setSelected:NO];
                } else if (self.optionHijos == 1) {
                    [self.btnSinHijos setSelected:NO];
                    [self.btnMenorUnAno setSelected:YES];
                    [self.btnMenorTresAno setSelected:NO];
                    [self.btnMenorCincoAno setSelected:NO];
                } else if (self.optionHijos == 2) {
                    [self.btnSinHijos setSelected:NO];
                    [self.btnMenorUnAno setSelected:NO];
                    [self.btnMenorTresAno setSelected: YES];
                    [self.btnMenorCincoAno setSelected:NO];
                } else if (self.optionHijos == 3) {
                    [self.btnSinHijos setSelected:NO];
                    [self.btnMenorUnAno setSelected:NO];
                    [self.btnMenorTresAno setSelected:NO];
                    [self.btnMenorCincoAno setSelected:YES];
                }
            }
            self.hijosActive = YES;
                
            [cell.btnCheck5 removeFromSuperview];
            [cell.lblOption5 removeFromSuperview];
            
            return cell;
        }
    } else if (indexPath.section == 3) {
        Options2ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"options2Cell" forIndexPath:indexPath];
        
        cell.backgroundView = [BackgroundTipo4PerfilCell new];
        
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        [cell.lblOption1 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        [cell.lblOption2 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        [cell.lblOption3 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        [cell.lblOption4 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        [cell.lblOption5 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        cell.lblTitulo.text = @"Sufre de alguna de las siguientes enfermedades:";
        cell.lblOption1.text = @"Hipertensión";
        cell.lblOption2.text = @"Diabetes";
        cell.lblOption3.text = @"Gastritis";
        cell.lblOption4.text = @"Corazón";
        cell.lblOption5.text = @"Colesterol";
        
        self.btnHipertension  = cell.btnCheck1;
        self.btnDiabetes      = cell.btnCheck2;
        self.btnGastritis     = cell.btnCheck3;
        self.btnCorazon       = cell.btnCheck4;
        self.btnColesterol    = cell.btnCheck5;
        
        [self setCheckboxEnfermedades:self.btnHipertension withValue:1];
        [self setCheckboxEnfermedades:self.btnDiabetes withValue:2];
        [self setCheckboxEnfermedades:self.btnGastritis withValue:3];
        [self setCheckboxEnfermedades:self.btnCorazon withValue:4];
        [self setCheckboxEnfermedades:self.btnColesterol withValue:5];
        
        
        if (!self.enfermedadesActive) {
            if (self.optionGastritis == 1) {
                [self.btnGastritis setSelected:YES];
            } else {
                [self.btnGastritis setSelected:NO];
            }
            if (self.optionHipertension == 1) {
                [self.btnHipertension setSelected:YES];
            } else {
                [self.btnHipertension setSelected:NO];
            }
            if (self.optionDiabetes == 1) {
                [self.btnDiabetes setSelected:YES];
            } else {
                [self.btnDiabetes setSelected:NO];
            }
            if (self.optionCorazon == 1) {
                [self.btnCorazon setSelected:YES];
            } else {
                [self.btnCorazon setSelected:NO];
            }
            if (self.optionColesterol == 1) {
                [self.btnColesterol setSelected:YES];
            } else {
                [self.btnColesterol setSelected:NO];
            }
        }
        self.enfermedadesActive = YES;

        
        return cell;
        
    } else {
        
        Options3ConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"options3Cell" forIndexPath:indexPath];
        
        cell.backgroundView = [BackgroundTipo4PerfilCell new];
        
        
        [cell.lblTitulo setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        [cell.lblOption1 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        [cell.lblOption2 setTextColor:[UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1]];
        
        
        cell.lblTitulo.text = @"Vive con alguna persona mayor de 65 años:";
        cell.lblOption1.text = @"Sí";
        cell.lblOption2.text = @"No";
        
        self.btnPersonaMayor  = cell.btnCheck1;
        self.btnPersonaMenor  = cell.btnCheck2;
        
        [self setOptionPersonaMayorMenor:self.btnPersonaMayor withValue:1];
        [self setOptionPersonaMayorMenor:self.btnPersonaMenor withValue:2];
        
        if (!self.mayorPersonaActive) {
            if (self.optionPersonaMayor) {
                [self.btnPersonaMayor setSelected:NO];
                [self.btnPersonaMenor setSelected:YES];
            } else {
                [self.btnPersonaMayor setSelected:YES];
                [self.btnPersonaMenor setSelected:NO];
            }
        }
        self.mayorPersonaActive = YES;
        
        return cell;
    }

}


// Funciones para los checks y options

// Soltero o Casado
- (void) btnOptionSelectCasado :(UIButton *) sender {
    
    [self.btnCasado setSelected:NO];
    [self.btnSoltero setSelected:NO];
    [sender setSelected:YES];
    
    if (sender.tag == 1) { //casado
        self.optionCasado = 1;
    } else if(sender.tag == 2) { //soltero
        self.optionCasado = 0;
    }
    
}

//Hijos
- (void) btnOptionSelectHijos :(UIButton *) sender {
    [self.btnSinHijos setSelected:NO];
    [self.btnMenorUnAno setSelected:NO];
    [self.btnMenorTresAno setSelected:NO];
    [self.btnMenorCincoAno setSelected:NO];
    [sender setSelected:YES];
    
    if (sender.tag == 1) { //sin hijos
        self.optionHijos = 0;
    } else if(sender.tag == 2) { //menor a un año
        self.optionHijos = 1;
    } else if(sender.tag == 3) { //menor a tres años
        self.optionHijos = 2;
    } else if(sender.tag == 4) { //menor a cinco años
        self.optionHijos = 3;
    }
}

//Enfermedades

- (void) btnCheckSelectHipertension :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.optionHipertension = 0;
    } else {
        [sender setSelected:YES];
        self.optionHipertension = 1;
    }
}
- (void) btnCheckSelectDiabetes :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.optionDiabetes = 0;
    } else {
        [sender setSelected:YES];
        self.optionDiabetes = 1;
    }
}
- (void) btnCheckSelectGastritis :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.optionGastritis = 0;
    } else {
        [sender setSelected:YES];
        self.optionGastritis = 1;
    }
}

- (void) btnCheckSelectCorazon :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.optionCorazon = 0;
    } else {
        [sender setSelected:YES];
        self.optionCorazon = 1;
    }
}

- (void) btnCheckSelectColesterol :(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        self.optionColesterol = 0;
    } else {
        [sender setSelected:YES];
        self.optionColesterol = 1;
    }
}


//Persona Mayor Menor
- (void) btnOptionSelectPersonaMayor :(UIButton *) sender {
    
    [self.btnPersonaMayor setSelected:NO];
    [self.btnPersonaMenor setSelected:NO];
    [sender setSelected:YES];
    
    if (sender.tag == 1) { //Persona Mayor a 64 años
        self.optionPersonaMayor = 1;
    } else if(sender.tag == 2) { //Persona Menor
        self.optionPersonaMayor = 0;
    }
}

- (void) setOptionCasadoSoltero :(UIButton *)sender withValue:(int) value {
    [sender setBackgroundColor:[UIColor whiteColor]];
    [sender setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    [sender addTarget:self action:@selector(btnOptionSelectCasado:) forControlEvents:UIControlEventTouchUpInside];
    sender.tag = value;
}
- (void) setOptionHijos :(UIButton *)sender withValue:(int) value {
    [sender setBackgroundColor:[UIColor whiteColor]];
    [sender setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    [sender addTarget:self action:@selector(btnOptionSelectHijos:) forControlEvents:UIControlEventTouchUpInside];
    sender.tag = value;
}
- (void) setCheckboxEnfermedades :(UIButton *)sender withValue:(int) value {
    [sender setBackgroundColor:[UIColor whiteColor]];
    [sender setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    
    if (value == 1) {
        [sender addTarget:self action:@selector(btnCheckSelectHipertension:) forControlEvents:UIControlEventTouchUpInside];
    } else if (value == 2) {
        [sender addTarget:self action:@selector(btnCheckSelectDiabetes:) forControlEvents:UIControlEventTouchUpInside];
    } else if (value == 3) {
        [sender addTarget:self action:@selector(btnCheckSelectGastritis:) forControlEvents:UIControlEventTouchUpInside];
    } else if (value == 4) {
        [sender addTarget:self action:@selector(btnCheckSelectCorazon:) forControlEvents:UIControlEventTouchUpInside];
    } else if (value == 5) {
        [sender addTarget:self action:@selector(btnCheckSelectColesterol:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    sender.tag = value;
}
- (void) setOptionPersonaMayorMenor :(UIButton *)sender withValue:(int) value {
    [sender setBackgroundColor:[UIColor whiteColor]];
    [sender setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateHighlighted];
    [sender setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    [sender addTarget:self action:@selector(btnOptionSelectPersonaMayor:) forControlEvents:UIControlEventTouchUpInside];
    sender.tag = value;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        return 184;
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        return 214;
    } else if (indexPath.section == 4 && indexPath.row == 0) {
        return 144;
    } else {
        return 44;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGuardarClick:(id)sender {
    
    [self btnOkView:nil];
    
    
    //NSLog(@"%@", self.txtNombres.text);
    //NSLog(@"%@", self.txtApellidos.text);
    //NSLog(@"%@", self.txtEdad.text);
    //NSLog(@"%@", self.txtDni.text);
    //NSLog(@"%@", self.txtEmail.text);
    //NSLog(@"%@", self.txtContrasena.text);
    //NSLog(@"%@", self.txtReContrasena.text);
    
    //NSLog(@"%i", self.optionCasado);
    //NSLog(@"%i", self.optionHijos);
    //NSLog(@"%i", self.optionPersonaMayor);
    
    //NSLog(@"%i", self.optionHipertension);
    //NSLog(@"%i", self.optionDiabetes);
    //NSLog(@"%i", self.optionGastritis);
    //NSLog(@"%i", self.optionCorazon);
    //NSLog(@"%i", self.optionColesterol);

    
    if (![self.txtNombres.text length] ||
        ![self.txtApellidos.text length] ||
        ![self.txtEdad.text length] ||
        ![self.txtDni.text length] ||
        ![self.txtEmail.text length] ||
        ![self.txtContrasena.text length] ||
        ![self.txtReContrasena.text length]
        ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debe de llenar todos los campos." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        
        [self btnOkView:nil];
        
        [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Guardando..."];
        [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
        
        
        NSString *ismarried = @"";
        if (self.optionCasado == 0) {
            ismarried = @"no";
        } else {
            ismarried = @"yes";
        }
        
        NSString *isolderperson = @"";
        if (self.optionPersonaMayor == 0) {
            isolderperson = @"no";
        } else {
            isolderperson = @"yes";
        }
        
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AppUrl getApiKey], @"apikey",
                                [AppUrl getIdUser], @"n_id_user",
                                self.txtNombres.text, @"c_name_user",
                                self.txtApellidos.text,@"c_lastname_user",
                                self.txtEmail.text, @"c_email_user",
                                self.txtContrasena.text, @"c_actual_pass_user",
                                self.txtReContrasena.text, @"c_pass_user",
                                self.txtEdad.text, @"n_age_user",
                                self.txtDni.text, @"c_dni_user",
                                self.txtTelefono.text, @"c_phone_user",
                                
                                ismarried, @"c_ismarried_user",
                                [NSString stringWithFormat:@"%i", self.optionHijos], @"n_nchildren_user",
                                
                                [NSString stringWithFormat:@"%i", self.optionHipertension], @"n_hipertension_user",
                                [NSString stringWithFormat:@"%i", self.optionDiabetes], @"n_diabetes_user",
                                [NSString stringWithFormat:@"%i", self.optionGastritis], @"n_gastritis_user",
                                [NSString stringWithFormat:@"%i", self.optionCorazon], @"n_corazon_user",
                                [NSString stringWithFormat:@"%i", self.optionColesterol], @"n_colesterol_user",
                                
                                isolderperson, @"c_olderperson_user",
                                nil];
        
        //NSLog(@"%@", params);
        
        AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getUpdateUser]];
        [request postPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            //NSLog(@"%@", result);
            //NSLog(@"status: %@", [result objectForKey:@"status"]);
            //NSLog(@"result: %@", [result objectForKey:@"iduser"]);
            
            if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
                
                [DejalBezelActivityView removeViewAnimated:YES];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
                
                    if ( [[result objectForKey:@"error"] isEqualToString:@"1"] ) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Usuario No Existe." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                        [alert show];
                    } else if ([[result objectForKey:@"error"] isEqualToString:@"2"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Contraseña Actual No Coincide." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                        [alert show];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Información de Usuario actualizada correctamente." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil , nil];
                        [alert show];
                        //NSLog(@"Usuario Actualizado :D");
                    }
                
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
    
    
    
}




#pragma mark -
#pragma UITextView Delegate

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
    [self.txtNombres resignFirstResponder];
    [self.txtApellidos resignFirstResponder];
    [self.txtDni resignFirstResponder];
    [self.txtEdad resignFirstResponder];
    [self.txtTelefono resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtContrasena resignFirstResponder];
    [self.txtReContrasena resignFirstResponder];
}



@end
