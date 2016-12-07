//
//  NSString+JRCommon.m
//  joyRunner
//
//  Created by Blade on 16/7/23.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "NSString+JRCommon.h"

@implementation NSString (JRCommon)
#pragma mark - About Price print
+ (NSString *)prettyStringForDouble:(double)doubleValue {
    NSString *ret = [NSString stringWithFormat:@"%.4f", doubleValue];
    NSInteger index = [ret length] - 1;
    const char *charactors = ret.UTF8String;
    while (index > -1 && (charactors[index] == '0' || charactors[index] == '.')) {
        if (charactors[index] == '.') {
            index--;
            break;
        }
        index--;
    }
    return [ret substringToIndex:index+1];
}
@end
