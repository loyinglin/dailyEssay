//
//  FirstViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"

@interface HomeViewController ()

@end

#define const_select_time @"open_select_time_board"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@ first", [self description]);
    [self viewInit];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"HomeModelChange" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self viewInit];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealc");
}

#pragma mark - view init

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"home show");
}

- (void)viewInit
{
    NSDate* birth = [[HomeModel instance] getBirthDate];
    NSDate* now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    long elapse = [now timeIntervalSinceDate:birth];
    
    self.myBirthDay.text = [NSString stringWithFormat:@"今天是生命中的第%ld天", elapse / (24 * 3600)];
    self.myDeadDay.text = [NSString stringWithFormat:@"还有%ld天", 365 * 70 - elapse / (24 * 3600)];
}

#pragma mark - ui
-(IBAction)onSelect:(id)sender
{
    [self performSegueWithIdentifier:const_select_time sender:self];
}

#pragma mark - delegate

#pragma mark - notify

@end
