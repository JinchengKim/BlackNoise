//
//  NSTimer+Block.m
//  joyRunner
//
//  Created by Sadaharu on 5/7/14.
//  Copyright (c) 2014 PolluxChen. All rights reserved.
//

#import "NSTimer+Block.h"

typedef void(^Timer_block)(NSTimer*);

@interface NSObject (BlockAdditions)

-(void)callBackBlock:(NSTimer*)timer;

@end

@implementation NSObject (BlockAdditions)

-(void)callBackBlock:(NSTimer*)timer;
{
    Timer_block block = (id)self;
    if (block) {
        block(timer);
    }
}

@end

@implementation NSTimer (Block)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)isRepeats block:(void(^)(NSTimer*))block
{
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:[block copy] selector:@selector(callBackBlock:) userInfo:nil repeats:isRepeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block {
    return [NSTimer timerWithTimeInterval:ti target:[block copy] selector:@selector(callBackBlock:) userInfo:userInfo repeats:yesOrNo];
    
}

@end
