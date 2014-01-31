//
//  customToolBar.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/2/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "customToolBar.h"

@implementation customToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

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
