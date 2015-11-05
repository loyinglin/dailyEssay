//
//  ModalMoveTransitionAnimation.m
//  TimeFlies
//
//  Created by 林伟池 on 15/11/4.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "ModalMoveTransitionAnimation.h"

@implementation ModalMoveTransitionAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    NSLog(@"ModalMoveTransitionAnimation show");
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    NSLog(@"from %@", fromVC);
//    NSLog(@"to %@", toVC);
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
//    [containerView sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
//        
//        NSLog(@"ccmople");
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
