//
//  UIView+RSAdditions.m
//  UIViewAdditions
//
//  Created by Josh Brown on 8/2/12.
//  Copyright (c) 2012 Roadfire Software. All rights reserved.
//

#import "UIView+RSAdditions.h"

@implementation UIView (RSAdditions)

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.top = bottom - self.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    self.left = right - self.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)showDebugFrame
{
    [self showDebugFrame:NO];
}

- (void)hideDebugFrame
{
    [[self layer] setBorderColor:nil];
    [[self layer] setBorderWidth:0.0f];
}

- (void)showDebugFrame:(BOOL)showInRelease
{
    [self performInRelease:showInRelease
                     block:^{
                         
                         [[self layer] setBorderColor:[[UIColor redColor] CGColor]];
                         [[self layer] setBorderWidth:1.0f];
                         
                     }];
    
}

#pragma mark - Helpers

- (void)performInDebug:(void (^)(void))block
{
    [self performInRelease:NO block:block];
}

- (void)performInRelease:(BOOL)release block:(void (^)(void))block
{
    if (block)
    {
#ifdef DEBUG
        block();
#else
        if (release)
        {
            block();
        }
#endif
    }
}

@end
