//
//  PortadaIniViewController.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 12/30/13.
//  Copyright (c) 2013 Janaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortadaIniViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewBanners;
@property (strong, nonatomic) IBOutlet UIPageControl *pagecontrol;



@property (nonatomic, strong) NSTimer *scrollingTimer;
@property CGFloat indexScrolling;


- (void) toolBarSetup:(UIViewController *) sender;
- (UIButton *) getBackButton;
- (UIButton *) getHomeButton;


+ (PortadaIniViewController *)sharedInstance;


    
@end
