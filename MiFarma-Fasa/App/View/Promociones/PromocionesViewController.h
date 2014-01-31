//
//  PromocionesViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/14/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromocionesViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnHome;

@property (strong, nonatomic) IBOutlet UISegmentedControl *btnSplit;

@property (strong, nonatomic) IBOutlet UITableView *tableview;



@end
