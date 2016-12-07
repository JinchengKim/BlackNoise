//
//  SettingVCPopAnimator.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "SettingVCPopAnimator.h"
#import "BNBaseVC.h"

@implementation SettingVCPopAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    BNBaseVC* toViewController   =  [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    BNBaseVC* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    toViewController.coverView.hidden = NO;
    toViewController.coverView.alpha = 1.0;
    fromViewController.bgView.alpha = 0.0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.coverView.alpha = 0.0;
        fromViewController.view.left = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        if (fromViewController.view.left != SCREEN_WIDTH) {
            fromViewController.bgView.alpha = 1.0;
        }
        toViewController.coverView.hidden = YES;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
