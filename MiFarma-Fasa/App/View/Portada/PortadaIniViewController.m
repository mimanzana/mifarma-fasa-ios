//
//  PortadaIniViewController.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 12/30/13.
//  Copyright (c) 2013 Janaq. All rights reserved.
//

#import "PortadaIniViewController.h"
#import "ItemPortada.h"
#import "ItemBanner.h"
#import "CustomNotificationButton.h"

#import "BackItem1Portada.h"
#import "BackItem2Portada.h"
#import "BackItem3Portada.h"

#import "BackgroundConfigurationWhiteView.h"

@interface PortadaIniViewController ()

@end

@implementation PortadaIniViewController

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

    CGFloat alto = [[UIScreen mainScreen] bounds].size.height;
    
    // NavigationBar
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:255.0/255 green:130.0/255 blue:1.0/255 alpha:1]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toolbar7.jpg"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cabecera.jpg"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.delegate = self;
    }
    

    // Menu de Items
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(80, 86)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    if (alto > 567) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [self.collectionView setFrame:CGRectMake(0, 163, 320, 354)];
        } else {
            [self.collectionView setFrame:CGRectMake(0, 163, 320, 334)];
        }
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [self.collectionView setFrame:CGRectMake(0, 150, 320, 290)];
        } else {
            [self.collectionView setFrame:CGRectMake(0, 150, 320, 270)];
        }
    }
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.bounces = YES;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    self.collectionView.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView setPagingEnabled:YES];
    
    // Banners
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout2 setItemSize:CGSizeMake(320, 137)];
    [flowLayout2 setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout2.minimumInteritemSpacing = 0;
    flowLayout2.minimumLineSpacing = 0;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.collectionViewBanners setFrame:CGRectMake(0, 63, 320, 140)];
    } else {
        [self.collectionViewBanners setFrame:CGRectMake(0, 0, 320, 228)];
    }

    [self.collectionViewBanners setCollectionViewLayout:flowLayout2];
    self.collectionViewBanners.bounces = YES;
    [self.collectionViewBanners setShowsHorizontalScrollIndicator:NO];
    [self.collectionViewBanners setShowsVerticalScrollIndicator:NO];
    self.collectionViewBanners.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    self.collectionViewBanners.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionViewBanners setPagingEnabled:YES];
 
    //self.collectionViewBanners.scrollEnabled = NO;
    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollingBanner) userInfo:nil repeats:YES];
    
    

    [self pageControlSetup];
    [self toolBarSetup:self];
    
}

// PageControl Setup -------------

- (void) pageControlSetup {
    CGFloat alto = [[UIScreen mainScreen] bounds].size.height;
    
    if (alto > 567) { //iphone 5
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [self.pagecontrol setCenter:CGPointMake(320/2, 495)];
        } else {
            [self.pagecontrol setCenter:CGPointMake(320/2, 435)];
        }
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [self.pagecontrol setCenter:CGPointMake(320/2, 415)];
        } else {
            [self.pagecontrol setCenter:CGPointMake(320/2, 355)];
        }
    }
    
    [self.pagecontrol setNumberOfPages:3];
    [self.pagecontrol addTarget:self action:@selector(btnChangePage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) scrollingBanner {
    self.indexScrolling = self.collectionViewBanners.contentOffset.x/320;
    if (self.indexScrolling>=self.collectionViewBanners.numberOfSections-1) {
        [self.collectionViewBanners setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [self.collectionViewBanners setContentOffset:CGPointMake(320*(self.indexScrolling+1), 0) animated:YES];
    }
}

- (void) btnChangePage:(UIPageControl *)sender {
    int page = sender.currentPage;
    CGRect frame = self.collectionView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.collectionView setContentOffset:frame.origin animated:YES];
}


// ToolBar Setup ------------------

- (void) toolBarSetup:(UIViewController *) sender {
    
    [sender.navigationController setToolbarHidden:NO];
    //ToolBar
    [sender.navigationController.toolbar setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
    
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHome setFrame:CGRectMake(0, 0, 35, 35)];
    [btnHome setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnHome setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icono.jpg"] forState:UIControlStateNormal];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icono.jpg"] forState:UIControlStateHighlighted];
    [btnHome addTarget:sender action:@selector(btnHome:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithCustomView:btnHome];
    
    
    CustomNotificationButton *btnNotification = [CustomNotificationButton buttonWithType:UIButtonTypeCustom];
    [btnNotification setFrame:CGRectMake(0, 0, 35, 35)];
    [btnNotification setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnNotification setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnNotification addTarget:sender action:@selector(btnNotification:) forControlEvents:UIControlEventTouchUpInside];
    [btnNotification setBackgroundImage:[UIImage imageNamed:@"campanaicono.jpg"] forState:UIControlStateHighlighted];
    UIBarButtonItem *buttonNotification = [[UIBarButtonItem alloc] initWithCustomView:btnNotification];
    [btnNotification setN:1];
    [btnNotification setNeedsDisplay];
    
    
    UIButton *btnConfig = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnConfig setFrame:CGRectMake(0, 0, 35, 35)];
    [btnConfig setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnConfig setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnConfig setBackgroundImage:[UIImage imageNamed:@"engranaj_icon.jpg"] forState:UIControlStateNormal];
    [btnConfig setBackgroundImage:[UIImage imageNamed:@"engranaj_icon.jpg"] forState:UIControlStateHighlighted];
    [btnConfig addTarget:sender action:@selector(btnConfig:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonConfig = [[UIBarButtonItem alloc] initWithCustomView:btnConfig];
    
    
    UIButton *btnDelivery = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDelivery setFrame:CGRectMake(0, 0, 83, 20)];
    [btnDelivery setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnDelivery setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnDelivery setBackgroundImage:[UIImage imageNamed:@"deliverysinborde.jpg"] forState:UIControlStateNormal];
    [btnDelivery setBackgroundImage:[UIImage imageNamed:@"deliverysinborde.jpg"] forState:UIControlStateHighlighted];
    [btnDelivery addTarget:sender action:@selector(btnDelivery:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonDelivery = [[UIBarButtonItem alloc] initWithCustomView:btnDelivery];
    
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:sender action:nil];
    
    NSArray *buttons = [NSArray arrayWithObjects: buttonHome,buttonNotification,buttonConfig,flex, buttonDelivery, nil];

    [sender setToolbarItems:buttons animated:YES];

}

// Buttons ToolBar
- (UIButton *) getBackButton {

    //Apariencia de BackButton
    // left Button
    UIImage *image = [UIImage imageNamed:@"icono_flecha.jpg"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    
    return button;
}

- (UIButton *) getHomeButton {
    // Right Button
    UIImage *image2 = [UIImage imageNamed:@"icono_menu.jpg"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:image2 forState:UIControlStateNormal];
    [button2 setImage:image2 forState:UIControlStateHighlighted];
    button2.frame = CGRectMake(0.0, 0.0, image2.size.width+10, image2.size.height);
    return button2;
}


//Controles de ToolBar
- (void) btnHome:(UIButton*) sender {
    NSLog(@"boton home");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) btnNotification:(UIButton*) sender {
    [self performSegueWithIdentifier:@"SegueNotificacion" sender:self];
}
- (void) btnConfig:(UIButton*) sender {
    [self performSegueWithIdentifier:@"SegueConfiguracion" sender:self];
}
- (void) btnDelivery:(UIButton*) sender {
    NSLog(@"boton delivery");
}

// -----------------------------------


- (void)viewWillAppear:(BOOL)animated{
    // NavigationBar
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toolbar7.jpg"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cabecera.jpg"] forBarMetrics:UIBarMetricsDefault];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark CollectionView Functions

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.collectionView == collectionView) {
        return 3;
    } else {
        return 3;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.collectionView == collectionView) {
        return 6;
    } else {
        return 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // ---- Items ----
    if (self.collectionView == collectionView) {
        if (indexPath.section >-1 && indexPath.section<3) {
            ItemPortada *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemPortada" forIndexPath:indexPath];
            

            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"promociones.jpg"];
                } else if (indexPath.row == 1) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"centros_salud.jpg"];
                } else if (indexPath.row == 2) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"vademecum.jpg"];
                } else if (indexPath.row == 3) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"farmacias.jpg"];
                } else if (indexPath.row == 4) {
                    [cell setBackgroundView:[BackItem2Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"pedidos.jpg"];
                } else if (indexPath.row == 5) {
                    [cell setBackgroundView:[BackgroundConfigurationWhiteView new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"reminder.jpg"];
                }

            } else if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"promociones.jpg"];
                } else if (indexPath.row == 1) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"centros_salud.jpg"];
                } else if (indexPath.row == 2) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"vademecum.jpg"];
                } else if (indexPath.row == 3) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"farmacias.jpg"];
                } else if (indexPath.row == 4) {
                    [cell setBackgroundView:[BackItem2Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"pedidos.jpg"];
                } else if (indexPath.row == 5) {
                    [cell setBackgroundView:[BackgroundConfigurationWhiteView new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"reminder.jpg"];
                }
                
            } else if (indexPath.section == 2) {
                if (indexPath.row == 0) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"promociones.jpg"];
                } else if (indexPath.row == 1) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"centros_salud.jpg"];
                } else if (indexPath.row == 2) {
                    [cell setBackgroundView:[BackItem1Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"vademecum.jpg"];
                } else if (indexPath.row == 3) {
                    [cell setBackgroundView:[BackItem3Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"farmacias.jpg"];
                } else if (indexPath.row == 4) {
                    [cell setBackgroundView:[BackItem2Portada new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"pedidos.jpg"];
                } else if (indexPath.row == 5) {
                    [cell setBackgroundView:[BackgroundConfigurationWhiteView new]];
                    cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
                    cell.imagen.image = [UIImage imageNamed:@"reminder.jpg"];
                }
                
            }
            
            return cell;
        } else {
            UICollectionViewCell *celda = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemPortada" forIndexPath:indexPath];
            return celda;
        }
    } else {
        // ---- Banners ----
        ItemBanner *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemBanner" forIndexPath:indexPath];
        cell.imagen.contentMode = UIViewContentModeScaleAspectFit;
        cell.imagen.image = [UIImage imageNamed:@"banner.jpg"];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
     // ---- Items ----
    if (self.collectionView == collectionView) {
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) { //promociones
                
            } else if (indexPath.row == 1) { //centros de salud
                [self performSegueWithIdentifier:@"SegueCentrosDeSalud" sender:self];
            } else if (indexPath.row == 2) { //vademecum
                
            } else if (indexPath.row == 3) { //farmacias
                [self performSegueWithIdentifier:@"SegueFarmacias" sender:self];
            } else if (indexPath.row == 4) { //pedidos
                
            } else if (indexPath.row == 5) { //reminder
                
            }
        }
        NSLog(@"Row: %i", indexPath.row);
        NSLog(@"Section: %i", indexPath.section);
    } else {
        // ---- Banners ----
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // ---- Items ----
    if (self.collectionView == collectionView) {
        CGFloat alto = [[UIScreen mainScreen] bounds].size.height;
        if (alto>567) {
            return CGSizeMake(100, 123);
        } else {
            return CGSizeMake(100, 91);
        }
        
    } else {
        // ---- Banners ----
        return CGSizeMake(320, 137);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
        if (self.collectionView == collectionView) {
            return UIEdgeInsetsMake(0 ,10, 0, 10);
        } else {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
}

#pragma mark ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pagecontrol.currentPage = self.collectionView.contentOffset.x / pageWidth;
}



#pragma mark -
#pragma mark Singleton Method
+ (PortadaIniViewController *)sharedInstance {
    static PortadaIniViewController *d=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d= [PortadaIniViewController new];
    });
    return d;
}


#pragma mark Navigation Controller Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
        if ( viewController == self ) {
            // NavigationBar
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toolbar7.jpg"] forBarMetrics:UIBarMetricsDefault];
            } else {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cabecera.jpg"] forBarMetrics:UIBarMetricsDefault];
            }
            
        }
}





@end
