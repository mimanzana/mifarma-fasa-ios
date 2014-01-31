//
//  BackgroundConfigurationWhiteView.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/13/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "BackgroundConfigurationWhiteView.h"

@implementation BackgroundConfigurationWhiteView

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
    CGContextSetRGBFillColor(context, 255.0/255, 255.0/255, 255.0/255, 1);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextRestoreGState(context);
}

@end
