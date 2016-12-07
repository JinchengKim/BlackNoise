//
//  CountDownMinLabel.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/28.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "CountDownMinLabel.h"
#import "BNTimer.h"

@interface CountDownMinLabel()

@end

@implementation CountDownMinLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)adjustWordSpace:(NSString*)text{
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: text];
    [attrStr addAttribute:NSKernAttributeName value:@(6) range:NSMakeRange(0, attrStr.length)];

    self.attributedText = attrStr;
}

- (void)setTextWithSec:(int64_t)ti{
    if (ti <= 0) {
        [self adjustWordSpace:@"00:00"];
        return;
    }
    
    int64_t min = ti/60;
    int64_t sec = ti%60;
    if (min >= 100) {
        [self adjustWordSpace:[NSString stringWithFormat:@"%03lld:%02lld",min,sec]];
    }else{
        [self adjustWordSpace:[NSString stringWithFormat:@"%02lld:%02lld",min,sec]];
    }
    
}
@end
