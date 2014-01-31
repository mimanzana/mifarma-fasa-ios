//
//  NuevaDireccionViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol listDirecciones <NSObject>
- (void) listarDirecciones : (UITableViewController *) c;
@end

@interface NuevaDireccionViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnClose;

@property(strong, nonatomic) UITextField *txtAlias;
@property(strong, nonatomic) UITextField *txtDistrito;
@property(strong, nonatomic) UITextField *txtVia;
@property(strong, nonatomic) UITextField *txtDireccion;
@property(strong, nonatomic) UITextField *txtNro;
@property(strong, nonatomic) UITextField *txtReferencia;

@property(strong, nonatomic) NSDictionary *obj;

@property (nonatomic, strong) id<listDirecciones>delegate;

@end
