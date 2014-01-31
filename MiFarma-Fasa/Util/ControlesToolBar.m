//
//  ControlesToolBar.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/17/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "ControlesToolBar.h"

@implementation ControlesToolBar


- (void) btnConfiguracion : (id) sender withSegue:(NSString *) segue {
    [sender performSegueWithIdentifier:segue sender:sender];
}




#pragma mark -
#pragma mark Singleton Method
+ (ControlesToolBar *)sharedInstance {
    static ControlesToolBar *d=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d= [ControlesToolBar new];
    });
    return d;
}


@end
