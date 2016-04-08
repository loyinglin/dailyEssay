//
//  TodoDetailController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TodoDetailController.h"
#import "UIViewController+TimeFliesNavigationItem.h"
#import "TodoModel.h"
#import "DoneModel.h"

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
//    [self.myText becomeFirstResponder];
    [self customView];
    
//    CIImage* image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customView {
//    [self lySetupRightItem];
}
#pragma mark - view init

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

- (IBAction)onDone:(id)sender
{
    if (![[DoneModel instance] getDoneCounts]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"固定到时间轴", nil) message:NSLocalizedString(@"固定后可在时间轴查看，同时不再可修改", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"否", nil) style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"是", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self onSure];
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self onSure];
    }

}

- (void)onSure
{
    if (self.index != -1) {
        [[TodoModel instance] deleteTodoByIndex:self.index];
    }
    
    [[DoneModel instance] addNewPassByText:self.myText.text Type:pass_type_thing];
    
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)onDelte:(id)sender
{
    if (self.index != -1) {
        [[TodoModel instance] deleteTodoByIndex:self.index];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - delegate

#pragma mark - notify

@end
