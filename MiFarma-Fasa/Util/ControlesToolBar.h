//
//  ControlesToolBar.h
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/17/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlesToolBar : NSObject

+ (ControlesToolBar *)sharedInstance;



- (void) btnConfiguracion : (id) sender withSegue:(NSString *) segue;

@end
