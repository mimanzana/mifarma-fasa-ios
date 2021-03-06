//
//  BackItem3Portada.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/15/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "BackItem3Portada.h"

@implementation BackItem3Portada

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
    
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 200/255.0f, 200/255.0f, 200/255.0f, 1.0f);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

@end
