//
//  ConfiguracionViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/7/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfiguracionViewController : UITableViewController<UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnHome;

@property(nonatomic, strong) UIButton *btnPush1;
@property(nonatomic, strong) UIButton *btnPush2;
@property(nonatomic, strong) UIButton *btnPush3;

@property(nonatomic, strong) UIButton *btnEmail1;
@property(nonatomic, strong) UIButton *btnEmail2;
@property(nonatomic, strong) UIButton *btnEmail3;

@end
