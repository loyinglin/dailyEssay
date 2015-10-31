//
//  FirstViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "HomeViewController.h"
#import "RWKnobControl.h"
#import "HomeModel.h"

@interface HomeViewController ()
{
    RWKnobControl* _knobControl;
}
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
    
    
    _knobControl = [[RWKnobControl alloc] initWithFrame:self.knobPlaceholder.bounds];
    [self.knobPlaceholder addSubview:_knobControl];
    
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
    self.view.tintColor = [UIColor lightGrayColor];
    
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    
    // Hooks up the knob control
    [_knobControl addTarget:self
                     action:@selector(handleValueChanged:)
           forControlEvents:UIControlEventValueChanged];

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
    [self viewInit];
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
    self.myBirthDay.text = [NSString stringWithFormat:NSLocalizedString(@"今天是生命中的第%d天", nil), [[HomeModel instance] getDaysNow]];
    self.myDeadDay.text = [NSString stringWithFormat:NSLocalizedString(@"还有%d天", nil), [[HomeModel instance] getDaysLeft]];
    float per = [[HomeModel instance] getDaysLeft] / (365 * 70.0);
    self.valueSlider.value = (1 - per);
    [_knobControl setValue:(1 - per) animated:YES];
    
    
    NSDate* current = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];
    
    self.myDay.text = [dateFormatter stringFromDate:current];
}

- (void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:self repeats:YES];
}

- (void)onTimer:(id)sender
{
    NSDate* current = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
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


- (IBAction)handleValueChanged:(id)sender {
    if(sender == self.valueSlider) {
        _knobControl.value = self.valueSlider.value;
    } else if(sender == _knobControl) {
        self.valueSlider.value = _knobControl.value;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == _knobControl && [keyPath isEqualToString:@"value"]) {
        self.myDeadDay.text = [NSString stringWithFormat:NSLocalizedString(@"还有%d天", nil), (long)(365 * 70 * (1- _knobControl.value))];
        NSDate* date = [[HomeModel instance] getBirthDate];
        date = [[NSDate alloc] initWithTimeInterval:((long)(365 * 70 * (_knobControl.value)) * 24 * 3600) sinceDate:date];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];
        
        self.myDay.text = [dateFormatter stringFromDate:date];
    }
}
#pragma mark - delegate

#pragma mark - notify

@end
