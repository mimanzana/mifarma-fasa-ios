//
//  DireccionesViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NuevaDireccionViewController.h"
#import "VerDireccionViewController.h"

@interface DireccionesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, listDirecciones, listDireccionesDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnHome;

@property (strong, nonatomic) IBOutlet UIButton *btnAgregar;

@property (strong, nonatomic) IBOutlet UILabel *lblTitulo;

- (IBAction)btnAgregarClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property(strong, nonatomic) NSMutableArray *lstDirecciones;


@end
