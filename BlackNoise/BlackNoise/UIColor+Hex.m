//
//  UIColor+Hex.m
//  joyruncrew
//
//  Created by SimonHuang on 16/1/28.
//  Copyright © 2016年 thejoyrun. All rights reserved.
//

#import "UIColor+Hex.h"

#define DEFAULT_VOID_COLOR [UIColor clearColor]

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSString *)hexColorStr {
    return [self colorWithHex:hexColorStr alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSString *)hexColorStr alpha:(CGFloat)alpha {
    NSString *cStr = [[hexColorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (cStr.length != 7) {
        return DEFAULT_VOID_COLOR;
    }
    
    uint32_t colorHex = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:cStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&colorHex];
    
    return [self HEXColor:colorHex alpha:alpha];
}

+ (UIColor *)HEXColor:(uint32_t)colorHex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((colorHex & 0xFF0000) >> 16))/255.0
                           green:((float)((colorHex & 0xFF00) >> 8))/255.0
                            blue:((float)(colorHex & 0xFF))/255.0 alpha:alpha];
}


@end
