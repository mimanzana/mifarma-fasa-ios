//
//  MicuentaViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MicuentaViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnHome;

@property(nonatomic, strong) UITextField *txtEmail;
@property(nonatomic, strong) UITextField *txtPass;


@end
