//
//  UIImage+Color.h
//  joyRunner
//
//  Created by SimonHuang on 15/6/11.
//  Copyright (c) 2015年 PolluxChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Color)

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

@end
