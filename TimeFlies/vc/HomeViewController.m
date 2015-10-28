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
{
    NSTimer* timer;
    BOOL myMoveEnd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    myMoveEnd = NO;
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@ first", [self description]);
    [self viewInit];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"HomeModelChange" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self viewInit];
    }];
    [self onTimer:nil];
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
    [self addTimer];
//    [self startMove];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
    [self endMove];
}

- (void)viewInit
{
    NSDate* birth = [[HomeModel instance] getBirthDate];
    NSDate* now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    long elapse = [now timeIntervalSinceDate:birth];
    
    self.myBirthDay.text = [NSString stringWithFormat:NSLocalizedString(@"今天是生命中的第%d天", nil), elapse / (24 * 3600)];
    self.myDeadDay.text = [NSString stringWithFormat:NSLocalizedString(@"还有%d天", nil), 365 * 70 - elapse / (24 * 3600)];
}

- (void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:self repeats:YES];
}

- (void)onTimer:(id)sender
{
    NSDate* current = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];

    self.myDay.text = [dateFormatter stringFromDate:current];
    
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    self.mySecond.text = [dateFormatter stringFromDate:current];
}

#pragma mark - ui
-(IBAction)onSelect:(id)sender
{
    [self performSegueWithIdentifier:const_select_time sender:self];
}


- (void)startMove
{
    myMoveEnd = NO;
    CGRect frame = self.img.frame;
    frame.origin.x = 0;
    [self.img setFrame:frame];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView animateWithDuration:2.0 animations:^{
        CGRect move = self.img.frame;
        move.origin.x = 150;
        [self.img setFrame:move];
    } completion:^(BOOL finished) {
        if (!myMoveEnd) {
            [self startMove];
        }
    }];
}

- (void)endMove
{
    myMoveEnd = YES;
}
#pragma mark - delegate

#pragma mark - notify

@end
