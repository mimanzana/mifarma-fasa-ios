//
//  PerfilViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/8/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfilViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnHome;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIButton *btnGuardar;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

- (IBAction)btnGuardarClick:(id)sender;


//Variables
@property(nonatomic,strong) UITextField *txtNombres;
@property(nonatomic,strong) UITextField *txtApellidos;
@property(nonatomic,strong) UITextField *txtEdad;
@property(nonatomic,strong) UITextField *txtDni;
@property(nonatomic,strong) UITextField *txtTelefono;
@property(nonatomic,strong) UITextField *txtEmail;
@property(nonatomic,strong) UITextField *txtContrasena;
@property(nonatomic,strong) UITextField *txtReContrasena;

@property(nonatomic,strong) UIButton *btnCasado;
@property(nonatomic,strong) UIButton *btnSoltero;

@property(nonatomic,strong) UIButton *btnSinHijos;
@property(nonatomic,strong) UIButton *btnMenorUnAno;
@property(nonatomic,strong) UIButton *btnMenorTresAno;
@property(nonatomic,strong) UIButton *btnMenorCincoAno;

@property(nonatomic,strong) UIButton *btnHipertension;
@property(nonatomic,strong) UIButton *btnDiabetes;
@property(nonatomic,strong) UIButton *btnGastritis;
@property(nonatomic,strong) UIButton *btnCorazon;
@property(nonatomic,strong) UIButton *btnColesterol;

@property(nonatomic,strong) UIButton *btnPersonaMayor;
@property(nonatomic,strong) UIButton *btnPersonaMenor;

@property int optionCasado;
@property int optionHijos;
@property int optionPersonaMayor;

@property int optionHipertension;
@property int optionDiabetes;
@property int optionGastritis;
@property int optionCorazon;
@property int optionColesterol;

@property BOOL casadoActive;
@property BOOL enfermedadesActive;
@property BOOL hijosActive;
@property BOOL mayorPersonaActive;


@end
