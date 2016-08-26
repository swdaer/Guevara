//
//  TabbarAnimation.m
//  Guevara
//
//  Created by 陈达尔 on 16/8/26.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import "TabbarAnimation.h"
@interface TabbarAnimation ()<UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) id transitionContext;

@end

@implementation TabbarAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIView * contextView = [transitionContext containerView];
//    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    toVC.view.alpha = 0.1;
    [contextView addSubview:toVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    }];
}

@end
