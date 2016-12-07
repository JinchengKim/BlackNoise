//
//  NSString+TBSearch.m
//  joyRunner
//
//  Created by Toby on 16/5/4.
//  Copyright © 2016年 PolluxChen. All rights reserved.
//

#import "NSString+TBSearch.h"


@implementation NSString (TBSearch)
- (NSArray *)componentsMatchedByPredicateFormat:(NSString *)predicateFormat
{
    NSError *error;
    NSMutableArray * arr = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:predicateFormat options:0 error:&error];
    if (regex != nil)
    {
        NSArray * matches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        
        if (matches.count > 0)
        {
            for (NSTextCheckingResult *textCheckingResult in matches)
            {
                [arr addObject:[self substringWithRange:textCheckingResult.range]];
            }
        }
    }
    
    return arr;
}
@end
