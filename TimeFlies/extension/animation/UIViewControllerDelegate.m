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
    
    self.lyController.transitioningDelegate = self;
}




- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    NSLog(@"presented %@", presented);
//    NSLog(@"presenting %@", presenting);
//    NSLog(@"source %@", source);
    [self.interActive wireToViewController:presented];
    return _animation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    NSLog(@"ask for dismiss %d", self.interActive.interacting);
    return self.interActive.interacting ? _interActiveAnimation : nil;
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interActive.interacting ? self.interActive : nil;
}

@end
