//
//  BackgroundTipo3PerfilCell.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/9/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "BackgroundTipo3PerfilCell.h"

@implementation BackgroundTipo3PerfilCell

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
    
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    
    CGContextMoveToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

@end
