//
//  UIViewControllerDelegate.m
//  TimeFlies
//
//  Created by 林伟池 on 15/11/4.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "UIViewControllerDelegate.h"

@interface UIViewControllerDelegate()

@end


@implementation UIViewControllerDelegate

- (void)awakeFromNib {
    
    _animation = [[ModalTransitionAnimation alloc] init];
    _interActive = [[ModalInterActiveTransitionAnimation alloc] init];
    _interActiveAnimation = [[ModalMoveTransitionAnimation alloc] init];
    
}




- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NSLog(@"ask for dismiss");
    return self.interActive.interacting ? _interActiveAnimation : _animation;
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interActive.interacting ? self.interActive : nil;
}

@end
