//
//  ThreeViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@ \n %@", [[self class] description], [self.tabBarItem description]);
//    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"abc" image:[UIImage imageNamed:@"first"] selectedImage:[UIImage imageNamed:@"second"]];
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

#pragma mark - view init

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController* controller = self.navigationController;
    UINavigationController* tabNa = self.tabBarController.navigationController;
    
}
#pragma mark - ui

-(IBAction)onslect:(id)sender
{
//    self.tabBarController.tabBar.hidden = YES;
//    [self.tabBarController setSelectedIndex:0];
    UINavigationController* controller = self.navigationController;
    UINavigationController* tabNa = self.tabBarController.navigationController;
    
    [self performSegueWithIdentifier:@"test_three" sender:self];
}

#pragma mark - delegate

#pragma mark - notify


@end
