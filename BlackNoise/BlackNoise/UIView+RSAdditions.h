//
//  UIView+RSAdditions.h
//  UIViewAdditions
//
//  Created by Josh Brown on 8/2/12.
//  Copyright (c) 2012 Roadfire Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewAutoresizingFlexibleTopAndBottomMargin UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
#define UIViewAutoresizingFlexibleLeftAndRightMargin UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

#define UIViewAutoresizingFlexibleCenter UIViewAutoresizingFlexibleTopAndBottomMargin | UIViewAutoresizingFlexibleLeftAndRightMargin
#define UIViewAutoresizingFlexibleSize UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

@interface UIView (RSAdditions)

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat height;
@property CGFloat width;

@property CGSize size;


- (void)showDebugFrame;
- (void)hideDebugFrame;
- (void)showDebugFrame:(BOOL)showInRelease;

@end
