//
//  UIWindow+Visible.h
//  joyRunner
//
//  Created by SimonHuang on 16/8/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Visible)

- (UIViewController *)visibleViewController;
- (UIViewController *)topViewController;
- (UINavigationController *)visibleNavigationController;

@end
