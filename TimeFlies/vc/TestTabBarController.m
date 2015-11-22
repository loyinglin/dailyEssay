//
//  TestTabBarController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "TestTabBarController.h"

@interface TestTabBarController ()

@end

@implementation TestTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.hidden = YES;

//    [self setSelectedIndex:3];
    self.tabBar.tintColor = [UIColor darkGrayColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    CATransition* animation = [CATransition animation];
//    [animation setDuration:0.3f];
//    [animation setType:kCATransitionFade];
//    [animation setSubtype:kCATransitionFromBottom];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [[self.view layer] addAnimation:animation forKey:@"switchView"];
    
//    NSLog(@"slect");
//    [super tabBar:tabBar didSelectItem:item];
}

@end
