//
//  NSString+JRCommon.h
//  joyRunner
//
//  Created by Blade on 16/7/23.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JRCommon)

/**
 *  Convert double value to string. Be careful about the percision of conversion, this function accepting 0.000,0 ~ 999,999,999.999,9
 *
 *  @param doubleValue The double value
 *
 *  @return String in perticualar percision.
 */
+ (NSString *)prettyStringForDouble:(double)doubleValue;
@end
