//
//  UIImage+fixOrientation.h
//  iLuxury
//
//  Created by Sadaharu on 8/26/13.
//  Copyright (c) 2013 PolluxChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

+ (UIImage*)scaleImage:(UIImage*)image scale:(float)scale;

+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)newSize;

+ (UIImage*)scaleImageToScreenSize:(UIImage*)image;

- (UIImage *)fixOrientation;

+ (UIImage *)getImageFromView:(UIView*)view;
+ (UIImage *)getHDImageFromView:(UIView *)view;
+ (UIImage *)getHDImageFromView:(UIView *)view expectFrame:(CGRect)expectFrame;
+ (UIImage *)appendImageFromImageArray:(NSArray *)imgArray;

- (UIImage *)circleImage;
@end
