//
//  DireccionesViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "DireccionesViewController.h"
#import "PortadaIniViewController.h"
#import "BackgroundConfiguration.h"

#import "ItemDireccionCell.h"

#import "BackgroundConfigurationCellFirst.h"
#import "BackgroundConfigurationSelectFirstCell.h"
#import "BackgroundConfigurationCells.h"
#import "BackgroundConfigurationSelectCell.h"

#import "BackgroundConfigurationWhiteView.h"
#import "ControlesToolBar.h"

#import "DejalActivityView.h"
#import "AFNetworking.h"
#import "AppUrl.h"

#import "VerDireccionViewController.h"

@interface DireccionesViewController ()

@end

@implementation DireccionesViewController

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
    
    self.lstDirecciones = [NSMutableArray array];
    
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
            [self.lblTitulo setCenter:CGPointMake(64, 23)];
            [self.btnAgregar setCenter:CGPointMake(272, 23)];
            [self.tableView setFrame:CGRectMake(0, 45, 320, 503)];
        }
    } else {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        } else {
            [self.lblTitulo setCenter:CGPointMake(64, 23)];
            [self.btnAgregar setCenter:CGPointMake(272, 23)];
            
            [self.tableView setFrame:CGRectMake(0, 40, 320, 420)];
        }
    }
    
    [self.tableView setBackgroundView:[BackgroundConfigurationWhiteView new]];
    [self cargarData];
}


- (void) cargarData {
    [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:@"Cargando Direcciones"];
    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    
    //Carga de data
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [AppUrl getApiKey], @"apikey",
                            [AppUrl getIdUser], @"n_id_user",
                            nil];
    
    AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getDataAddress]];
    [request postPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //NSLog(@"%@", result);
        
        if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
            
            [self.lstDirecciones removeAllObjects];
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
            
            for (NSDictionary *d in [result objectForKey:@"address"]) {
                [self.lstDirecciones addObject:d];
            }
            
            [self.tableView reloadData];
            
            CATransition *animation = [CATransition animation];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFade];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [animation setFillMode:kCAFillModeBoth];
            [animation setDuration:.3];
            [[self.view layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
            
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

// ---------------------------



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lstDirecciones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemDireccionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DireccionCell"];
    
    if (indexPath.row!=0) {
        cell.backgroundView = [BackgroundConfigurationCells new];
        cell.selectedBackgroundView = [BackgroundConfigurationSelectCell new];
    } else {
        cell.backgroundView = [BackgroundConfigurationCellFirst new];
        cell.selectedBackgroundView = [BackgroundConfigurationSelectFirstCell new];
    }
    
    cell.lblTitulo.text = [[self.lstDirecciones objectAtIndex:indexPath.row] objectForKey:@"c_alias_address"];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAgregarClick:(id)sender {
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([[segue identifier] isEqualToString:@"SegueNuevaDireccion"]) {
        UINavigationController *d = [segue destinationViewController];
        NuevaDireccionViewController *nav = (NuevaDireccionViewController *) d.topViewController;
        nav.delegate = self;
    }
    if([[segue identifier] isEqualToString:@"SegueVerDireccion"]) {
        VerDireccionViewController *d = segue.destinationViewController;
        d.dic = [self.lstDirecciones objectAtIndex: [[self.tableView indexPathForSelectedRow] row]];
        d.delegate = self;
    }

}


#pragma mark - Protocolos

- (void)listarDirecciones : (UITableViewController *) c {
    NuevaDireccionViewController *d = (NuevaDireccionViewController *) c;
    [self.lstDirecciones addObject:d.obj];
    [self.tableView reloadData];
//    [self cargarData];
}

- (void) listarVerDirecciones:(UITableViewController *)c  {
    VerDireccionViewController *d = (VerDireccionViewController *) c;
    [self.lstDirecciones removeObject:d.dic];
    [self.tableView reloadData];
}


@end
