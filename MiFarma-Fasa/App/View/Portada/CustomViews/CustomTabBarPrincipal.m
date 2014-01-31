//
//  CustomTabBarPrincipal.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/3/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "CustomTabBarPrincipal.h"

@implementation CustomTabBarPrincipal

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetRGBFillColor(context, 247.0/255, 247.0/255, 247.0/255, 1);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 128.0/255, 128.0/255, 128.0/255, 1.0f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

}


@end
