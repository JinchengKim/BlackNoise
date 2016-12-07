//
//  NSString+Size.m
//  SHSlideNewsViewController
//
//  Created by SimonHuang on 15/5/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString(Size)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    
    NSString *handlingStr = [self stringByReplacingOccurrencesOfString:@" " withString:@"a"];
    CGSize size =  [handlingStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpace:(CGFloat)lineSpace{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attrs = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName: font};
    
    NSString *handlingStr = [self stringByReplacingOccurrencesOfString:@" " withString:@"a"];
    CGSize size =  [handlingStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return size;
}

@end
