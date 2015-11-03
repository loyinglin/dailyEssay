//
//  TabbarControllerDelegate.m
//  TimeFlies
//
//  Created by 林伟池 on 15/11/3.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TabbarControllerDelegate.h"
#import "TabbarTransitionRightAnimation.h"
#import "TabbarTransitionLeftAnimation.h"


@interface TabbarControllerDelegate()
@property (weak, nonatomic) IBOutlet UITabBarController *tabbarController;
@property(nonatomic,strong)TabbarTransitionRightAnimation *myRight;
@property(nonatomic,strong)TabbarTransitionLeftAnimation *myLeft;
@end


@implementation TabbarControllerDelegate

- (instancetype)init
{
    self = [super init];
//    if (!_animation) {
//        _animation = [[TabbarTransitionAnimation alloc] init];
//    }
    return self;
}

- (void)awakeFromNib {
    self.myRight = [[TabbarTransitionRightAnimation alloc] init];
    self.myLeft = [[TabbarTransitionLeftAnimation alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    long from = [tabBarController.viewControllers indexOfObject:fromVC];
    long to = [tabBarController.viewControllers indexOfObject:toVC];
    
    if (from > to){
        return self.myLeft;
    }
    else{
        return self.myRight;
    }
}

@end
