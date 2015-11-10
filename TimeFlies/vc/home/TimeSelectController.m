//
//  TimeSelectController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TimeSelectController.h"
#import "HomeModel.h"

@interface TimeSelectController ()

@end

@implementation TimeSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.myDatePicker setMaximumDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0]];
    [self.myDatePicker setDate:[[HomeModel instance] getBirthDate]];
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
//    NSLog(@"appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    NSLog(@"dis");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    NSLog(@"dis %@", self.view.superview);
}
#pragma mark - ui

- (IBAction)onClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.lyDelegate dismissViewController:self];
}

- (IBAction)onSave:(id)sender
{
    [[HomeModel instance] setBirthDate:[self.myDatePicker date]];
    [self onClose:sender];
}

- (IBAction)onValueChange:(id)sender
{
    NSLog(@"%@", [self.myDatePicker date]);
}
#pragma mark - delegate

#pragma mark - notify


@end
