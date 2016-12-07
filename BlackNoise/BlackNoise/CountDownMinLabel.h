//
//  CountDownMinLabel.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/28.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownMinLabel : UILabel
@property (nonatomic, assign) int64_t totalSec;
@property (nonatomic, assign) int64_t leftSec;

- (void)adjustWordSpace:(NSString*)text;
- (void)setTextWithSec:(int64_t)ti;

@end
