//
//  NSString+Size.h
//  SHSlideNewsViewController
//
//  Created by SimonHuang on 15/5/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Size)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpace:(CGFloat)lineSpace;

@end
