//
//  UIColor+Extensions.m
//  Done
//
//  Created by Tim Mikelj on 19/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

/// Returns label colour for iOS 13+ or black for earlier versions
+ (UIColor *)labelColorBackwardsCompatible {
    if (@available(iOS 13.0, *)) {
        return [UIColor labelColor];
    } else {
        return [UIColor blackColor];
    }
}

@end
