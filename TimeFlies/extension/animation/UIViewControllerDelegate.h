//
//  UIViewControllerDelegate.h
//  TimeFlies
//
//  Created by 林伟池 on 15/11/4.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ModalTransitionAnimation.h"
#import "ModalInterActiveTransitionAnimation.h"
#import "ModalMoveTransitionAnimation.h"


@interface UIViewControllerDelegate : NSObject<UIViewControllerTransitioningDelegate>


@property (weak, nonatomic) IBOutlet UIViewController *lyController;


@property(nonatomic,strong)ModalTransitionAnimation *animation;
@property(nonatomic,strong)ModalInterActiveTransitionAnimation *interActive;
@property(nonatomic,strong)ModalMoveTransitionAnimation *interActiveAnimation;


@end
