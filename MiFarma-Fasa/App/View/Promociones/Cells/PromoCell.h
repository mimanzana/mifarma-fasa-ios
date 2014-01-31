//
//  PromoCell.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/14/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imagenPromo;

@property (strong, nonatomic) IBOutlet UILabel *lblTitulo;
@property (strong, nonatomic) IBOutlet UILabel *lblDescripcion;
@property (strong, nonatomic) IBOutlet UILabel *lblCodigo;
@property (strong, nonatomic) IBOutlet UILabel *lblFecha;

@end
