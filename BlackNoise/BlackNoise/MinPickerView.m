//
//  MinPickerView.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/19.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "MinPickerView.h"
#import "BNTimer.h"

@interface MinPickerView()
@property (nonatomic, strong) NSTimer *hideTimer;
@property (nonatomic, assign) int8_t countDownTime;
@end

@implementation MinPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.countDownTime = 0;
    }
    return self;
}

- (void)addTimer{
    [self.hideTimer invalidate];
    WeakSelf
    self.hideTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer){
        weakSelf.countDownTime++;
        if (weakSelf.countDownTime > 2) {
            if (self.hideBlock) {
                self.hideBlock(YES);
            }
        }
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:self.hideTimer forMode:NSRunLoopCommonModes];
    [_hideTimer fire];
}

- (void)stopTimer
{
    [_hideTimer invalidate];
    _hideTimer = nil;
    self.countDownTime = 0;
}


- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    self.countDownTime = 0;
    if (hidden) {
        [self stopTimer];
    }else{
        [self addTimer];
    }
}

@end
