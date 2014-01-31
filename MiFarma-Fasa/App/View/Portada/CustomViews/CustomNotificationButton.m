//
//  CustomNotificationButton.m
//  MiFarma-Fasa
//
//  Created by Mi Manzana on 1/2/14.
//  Copyright (c) 2014 Janaq. All rights reserved.
//

#import "CustomNotificationButton.h"

@implementation CustomNotificationButton

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
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    //imagen
    UIImage  *img = [UIImage imageNamed:@"campanaicono.jpg"];
    CGContextRotateCTM(context, 360*M_PI/360);
    CGContextDrawImage(context, CGRectMake(-36, -35, 35, 35), img.CGImage );
    CGContextRotateCTM(context, 360*M_PI/360);

    if (self.n > 0) {
        //circulo
        CGContextSetLineWidth(context, 0.1);
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGRect rectangle = CGRectMake( 20 ,0 , 15, 15);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:239.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1].CGColor);
        CGContextFillEllipseInRect(context, rectangle);
    
        //texto
        NSString *string = [NSString stringWithFormat:@"%i", (int)self.n];
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1].CGColor);
        CGContextSetShadow(context, CGSizeMake(10.0f, 10.0f), 10.0f);
    
        if (self.n/10 >= 1) {
            [string drawAtPoint:CGPointMake(22, 1) withFont:[UIFont boldSystemFontOfSize:10.0f]];
        } else {
            [string drawAtPoint:CGPointMake(24, 0) withFont:[UIFont boldSystemFontOfSize:12.0f]];
        }
    }
    
    

    
}


-(void) showNumber:(CGFloat) number {
    self.n = number;
}

@end
