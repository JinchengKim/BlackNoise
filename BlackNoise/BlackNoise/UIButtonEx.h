//
//  UIButtonEx.h
//  BlackNoise
//
//  Created by 李金 on 2016/11/14.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonEx : UIButton
{
    NSMutableDictionary* _backgroundColors;
    NSMutableDictionary* _borderColors;
}

@property (nonatomic, weak) NSObject* userInfo;
@property CGFloat touchVerticalExtension;
@property CGFloat touchHorizontalExtension;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor*)backgroundColorForState:(UIControlState)state;

- (void)setBorderColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor*)borderColorForState:(UIControlState)state;
- (void)setHighlightedCoverColorBlack;
- (void)setHighlightedCoverColor:(UIColor *)coverColor;

- (void)buttonBeginAnimation;
- (void)buttonEndAnimation;
@end
