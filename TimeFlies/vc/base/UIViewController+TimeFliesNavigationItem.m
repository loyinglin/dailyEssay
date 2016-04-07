//
//  UIViewController+TimeFliesNavigationItem.m
//  TimeFlies
//
//  Created by 林伟池 on 16/3/2.
//  Copyright © 2016年 林伟池. All rights reserved.
//

#import "UIViewController+TimeFliesNavigationItem.h"
#import "LYColor.h"

@implementation UIViewController (TimeFliesNavigationItem)

- (void)lySetupLeftItem {
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:UIColorFromRGB(0x778c93)} forState:UIControlStateNormal];
}

- (void)lySetupBackItem {
    if (!self.navigationItem.backBarButtonItem) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:UIColorFromRGB(0x778c93)} forState:UIControlStateNormal];
}

- (void)lySetupRightItem {
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:UIColorFromRGB(0x778c93)} forState:UIControlStateNormal];
}

@end
