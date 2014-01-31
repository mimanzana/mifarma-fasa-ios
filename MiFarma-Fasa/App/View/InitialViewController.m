//
//  InitialViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 12/11/13.
//  Copyright (c) 2013 Janaq. All rights reserved.
//

#import "InitialViewController.h"
#import "DejalActivityView.h"
#import "AFNetworking.h"
#import "AppUrl.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

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

    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Iniciando"];
    [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = YES;
    

    AFHTTPClient *request = [[AFHTTPClient alloc] initWithBaseURL:[AppUrl getStatus]];
    [request postPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"status: %@", [result objectForKey:@"status"]);
        NSLog(@"result: %@", [result objectForKey:@"result"]);
        if ( [[result objectForKey:@"status"] isEqualToString:@"true"] ) {
            if ([[result objectForKey:@"result"] isEqualToString:@"si"]) { //hay cambios
                NSLog(@"Hay cambios");
                
                //Bajar todas las notificaciones ---
                
                
                
                // ----------------------------------
                
                [self performSegueWithIdentifier:@"PortadaSegue" sender:self];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
            } else { //no hay cambios
                NSLog(@"NO Hay cambios");
                [self performSegueWithIdentifier:@"PortadaSegue" sender:self];
                [DejalBezelActivityView currentActivityView].showNetworkActivityIndicator = NO;
            }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
