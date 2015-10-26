//
//  FirstViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

#define const_select_time @"open_select_time_board"

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@ first", [self description]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view init

#pragma mark - ui
-(IBAction)onSelect:(id)sender
{
    [self performSegueWithIdentifier:const_select_time sender:self];
}

#pragma mark - delegate

#pragma mark - notify

@end
