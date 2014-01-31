//
//  PromocionesViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/14/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "PromocionesViewController.h"

#import "PortadaIniViewController.h"
#import "BackgroundTablePromoView.h"

#import "PromoCell.h"

#import "MicuentaViewController.h"

#import "AppUrl.h"

@interface PromocionesViewController ()

@end

@implementation PromocionesViewController

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
    
    
    if (alto > 567) { //iphone 5
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        } else {
            [self.btnSplit setCenter:CGPointMake(320/2, 30)];
            [self.tableview setFrame:CGRectMake(0, 55, 320, 495)];
        }
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        } else {
            [self.btnSplit setCenter:CGPointMake(320/2, 34)];
            [self.tableview setFrame:CGRectMake(0, 65, 320, 395)];
        }
    }
    
    [self.tableview setBackgroundView:[BackgroundTablePromoView new]];
    
    
    // Validación de usuario registrado.
    
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

}
- (void) btnConfig:(UIButton*) sender {
    [self performSegueWithIdentifier:@"SegueConfiguracion" sender:self];
}

- (void) btnDelivery:(UIButton*) sender {
    NSLog(@"boton delivery");
}
// -------------------


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellPromo"];
    
    cell.imagenPromo.contentMode = UIViewContentModeScaleAspectFit;
    cell.imagenPromo.image = [UIImage imageNamed:@"itemp.jpg"];
    cell.lblTitulo.text = @"Ninet";
    cell.lblDescripcion.text = @"Por compras de pañales Ninet, llévate el segundo ...";
    cell.lblCodigo.text = @"Código #8324839284";
    cell.lblFecha.text = @"Del 20/12/2013 al 31/01/2014";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 153;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
