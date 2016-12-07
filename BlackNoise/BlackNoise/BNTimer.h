//
//  BNTimer.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/18.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNTimer : NSTimer

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)isRepeats block:(void(^)(NSTimer*))block;
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block;
@end
