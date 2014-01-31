//
//  CustomSeguePortada.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 12/12/13.
//  Copyright (c) 2013 Janaq. All rights reserved.
//

#import "CustomSeguePortada.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomSeguePortada


- (void)perform{
    UIViewController *srcViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destViewController = (UIViewController *) self.destinationViewController;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [srcViewController.view.window.layer addAnimation:transition forKey:nil];
    [srcViewController presentViewController:destViewController animated:NO completion:nil];
}


@end
