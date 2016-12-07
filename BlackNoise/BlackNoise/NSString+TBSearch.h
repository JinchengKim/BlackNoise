//
//  NSString+TBSearch.h
//  joyRunner
//
//  Created by Toby on 16/5/4.
//  Copyright © 2016年 PolluxChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TBSearch)
- (NSArray *)componentsMatchedByPredicateFormat:(NSString *)predicateFormat;
@end
