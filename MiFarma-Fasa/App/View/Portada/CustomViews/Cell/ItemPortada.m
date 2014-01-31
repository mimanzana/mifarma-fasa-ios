//
//  ItemPortada.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 12/13/13.
//  Copyright (c) 2013 Janaq. All rights reserved.
//

#import "ItemPortada.h"

@implementation ItemPortada

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
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));    
    CGContextRestoreGState(context);
}


@end
