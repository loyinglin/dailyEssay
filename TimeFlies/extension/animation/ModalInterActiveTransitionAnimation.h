//
//  ModalInterActiveTransitionAnimation.h
//  TimeFlies
//
//  Created by 林伟池 on 15/11/4.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModalInterActiveTransitionAnimation : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign)BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;


@end
