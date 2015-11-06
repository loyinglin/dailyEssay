//
//  TabbarTransitionLeftAnimation.m
//  TimeFlies
//
//  Created by 林伟池 on 15/11/3.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TabbarTransitionLeftAnimation.h"

#define PERSPECTIVE -1.0/200

@implementation TabbarTransitionLeftAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    CATransform3D viewFromTransform = CATransform3DMakeRotation(-M_PI/2, 0, 1, 0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
    viewFromTransform.m34 = PERSPECTIVE;
    viewToTransform.m34 = PERSPECTIVE;
    
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *container = [transitionContext containerView];
    
    [fromVC.view.layer setAnchorPoint:CGPointMake(0, 0.5)];
    [toVC.view.layer setAnchorPoint:CGPointMake(1, 0.5)];
    
    toVC.view.layer.transform = viewToTransform;
    
    [container addSubview:toVC.view];
    container.transform = CGAffineTransformMakeTranslation(-container.frame.size.width/2.0,0);
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.layer.transform = viewFromTransform;
        toVC.view.layer.transform = CATransform3DIdentity;
        [container setTransform:CGAffineTransformMakeTranslation(container.frame.size.width/2.0, 0)];
        
        
    } completion:^(BOOL finished) {
//        NSLog(@"an %@", fromVC.view.superview);
        
        fromVC.view.layer.transform = CATransform3DIdentity;
        toVC.view.layer.transform = CATransform3DIdentity;
        [fromVC.view.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        [toVC.view.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        [container setTransform:CGAffineTransformIdentity];
        
        [transitionContext completeTransition:YES];
    }];
    
    
}

@end
