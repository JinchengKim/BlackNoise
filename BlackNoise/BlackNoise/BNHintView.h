//
//  BNHintView.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/30.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNHintView : UIView
+ (void)showHint:(NSString *)message;

+ (void)showHint:(NSString *)message onView:(UIView *)view;

@end
