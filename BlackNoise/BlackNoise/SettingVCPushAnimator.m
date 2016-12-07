//
//  SettingVCPushAnimator.m
//  BlackNoise
//
//  Created by 李金 on 2016/11/24.
//  Copyright © 2016年 kingandyoga. All rights reserved.
//

#import "SettingVCPushAnimator.h"
#import "BNBaseVC.h"

@implementation SettingVCPushAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    BNBaseVC* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    BNBaseVC* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.left = SCREEN_WIDTH;
    fromViewController.coverView.hidden = NO;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;
        toViewController.view.left = 0;
        fromViewController.coverView.alpha = 1;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
