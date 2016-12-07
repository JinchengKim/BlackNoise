//
//  NSTimer+ABlock.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/30.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "NSTimer+ABlock.h"

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

@implementation NSTimer (ABlock)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)isRepeats block:(void(^)(NSTimer*))block
{
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:[block copy] selector:@selector(callBackBlock:) userInfo:nil repeats:isRepeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block {
    return [NSTimer timerWithTimeInterval:ti target:[block copy] selector:@selector(callBackBlock:) userInfo:userInfo repeats:yesOrNo];
    
}

@end
