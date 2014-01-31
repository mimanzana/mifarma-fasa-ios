//
//  VerDireccionViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/29/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol listDireccionesDelegate <NSObject>
- (void) listarVerDirecciones : (UITableViewController *) c;
@end



@interface VerDireccionViewController : UITableViewController

@property(nonatomic, strong) NSDictionary *dic;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (nonatomic, strong) id<listDireccionesDelegate>delegate;

@end
