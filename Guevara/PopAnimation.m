//
//  PopAnimation.m
//  Guevara
//
//  Created by 陈达尔 on 16/8/26.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import "PopAnimation.h"
@interface PopAnimation ()<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) CGRect finishRect;
@property (nonatomic, strong) UIImageView * cellImg;

@property (weak, nonatomic) id transitionContext;

@property (nonatomic, strong) UIViewController * fromVC;
@property (nonatomic, strong) UIViewController * toVC;
@end

@implementation PopAnimation
- (void)setStartRect:(CGRect)sRect finishRect:(CGRect)fRect cellImg:(UIImageView *)img
{
    _startRect = sRect;
    _finishRect = fRect;
    _cellImg = [[UIImageView alloc] initWithImage:img.image];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIView * contextView = [transitionContext containerView];
    _fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _toVC.view.alpha = 0.1;
    _toVC.view.hidden = YES;
    _toVC.view.frame = _fromVC.view.frame;
    [contextView addSubview:_toVC.view];    
    _cellImg.frame = _startRect;
    [contextView addSubview:_cellImg];
    
    [self fromVCHidden];
}

- (void)fromVCHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        _fromVC.view.alpha = 0.1;
    } completion:^(BOOL finished) {
        _fromVC.view.hidden = YES;
        [self cellImgMove];
    }];
}

- (void)cellImgMove
{
    [UIView animateWithDuration:0.6 animations:^{
        _cellImg.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-_finishRect.size.width)/2, _startRect.origin.y, _finishRect.size.width, _finishRect.size.height);
    } completion:^(BOOL finished) {
        [self cellImgFinish];
    }];
}

- (void)cellImgFinish
{
    [UIView animateWithDuration:0.6 animations:^{
        _cellImg.frame = _finishRect;
    } completion:^(BOOL finished) {
        [self toVCShow];
    }];
}

- (void)toVCShow
{
    _toVC.view.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [_cellImg removeFromSuperview];
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    }];
}


@end
