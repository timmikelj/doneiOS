//
//  UIImage+Extensions.m
//  Done
//
//  Created by Tim Mikelj on 19/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

- (UIImage *)tintColor:(UIColor *)tintColor {
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context, [tintColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
