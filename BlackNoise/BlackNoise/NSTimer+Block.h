//
//  NSTimer+Block.h
//  joyRunner
//
//  Created by Sadaharu on 5/7/14.
//  Copyright (c) 2014 PolluxChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)isRepeats block:(void(^)(NSTimer*))block;
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block ;

@end
