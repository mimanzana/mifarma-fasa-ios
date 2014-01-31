//
//  BackgroundConfiguration.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/7/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "BackgroundConfiguration.h"

@implementation BackgroundConfiguration

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
    CGContextSetRGBFillColor(context, 248.0/255, 248.0/255, 248.0/255, 1);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextRestoreGState(context);
}

@end
