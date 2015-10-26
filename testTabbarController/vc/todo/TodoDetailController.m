//
//  TodoDetailController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TodoDetailController.h"
#include "TodoModel.h"

@interface TodoDetailController ()

@end

@implementation TodoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.index >= 0) {
        Thing* item = [[TodoModel instance] getThingByIndex:self.index];
        if (item && item.text) {
            self.myText.text = item.text;
        }
    }
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - ui

- (IBAction)onSave:(id)sender
{
    if (self.index != -1) {
        [[TodoModel instance] modifyTodoByIndex:self.index Text:self.myText.text];
    }
    else{
        [[TodoModel instance] addNewTodo:self.myText.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - delegate

#pragma mark - notify

@end
