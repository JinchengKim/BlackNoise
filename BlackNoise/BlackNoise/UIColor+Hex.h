//
//  UIColor+Hex.h
//  joyruncrew
//
//  Created by SimonHuang on 16/1/28.
//  Copyright © 2016年 thejoyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

// UIColor form RGB HEX String value and alpha
#define HEX_COLORS_A(RGB_HEX_STR, ALPHA) [UIColor colorWithHex:RGB_HEX_STR alpha:ALPHA]
// UIColor form RGB HEX String value and alpha
#define HEX_COLORS(RGB_HEX_STR) HEX_COLORS_A(RGB_HEX_STR,1.)
// UIColor form RGB HEX value and alpha
#define HEX_COLOR_A(RGB_HEX, ALPHA) [UIColor HEXColor:RGB_HEX alpha:ALPHA]
// UIColor form RGB HEX value
#define HEX_COLOR(RGB_HEX) HEX_COLOR_A(RGB_HEX,1.)

@interface UIColor (Hex)

/**
 * format: #aabbcc
 * sample: #FFFFFF
 **/
+ (UIColor *)colorWithHex:(NSString *)hexColorStr;
+ (UIColor *)colorWithHex:(NSString *)hexColorStr alpha:(CGFloat)alpha;

+ (UIColor *)HEXColor:(uint32_t)colorHex alpha:(CGFloat)alpha;
@end
