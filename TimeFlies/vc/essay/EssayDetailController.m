//
//  EssayDetailControllerViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayDetailController.h"
#import "EssayModel.h"
#import "DoneModel.h"
#import "WeixinShare.h"
#import "DoneModel.h"
#import "HomeModel.h"
#import "WXApi.h"
#import "RACEXTScope.h"
#import <ReactiveCocoa.h>

@interface EssayDetailController ()

@end

@implementation EssayDetailController
{
    Essay* essay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.index >= 0) {
        essay = [[EssayModel instance] getEssayByIndex:self.index];
        if (essay && essay.text) {
            self.text.text = essay.text;
        }
    }
    else{
        self.text.text = [NSString stringWithFormat:@"%ld ", [[HomeModel instance] getDaysLeft]];        
    }
    
    if (![WXApi isWXAppInstalled]) {
        self.shareToFavorite.hidden = self.shareToSession.hidden = self.shareToTimeline.hidden = YES;
    }
    
    [self.text becomeFirstResponder];
    @weakify(self);
    self.attachButton.rac_command = [[RACCommand alloc] initWithEnabled:[self isEssayVaildSignal] signalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self onAttachToTimeLine];
    }];
    
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


- (RACSignal*) isEssayVaildSignal{
    return [RACObserve(self, text.text) map:^id(NSString* str) {
        return @(str.length != 0);
    }];
}

- (RACSignal*) onAttachToTimeLine{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        if (![[DoneModel instance] getDoneCounts]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"固定到时间轴", nil) message:NSLocalizedString(@"固定后可在时间轴查看，同时不再可修改", nil) preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"否", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendCompleted];
            }];
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

        return nil;
    }];
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
        [[EssayModel instance] modifyEssay:self.text.text Index:self.index];
    }
    else{
        [[EssayModel instance] addNewEssay:self.text.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)onSure
{
    if (self.index != -1) {
        [[EssayModel instance] deleteEssayByIndex:self.index];
    }
    [[DoneModel instance] addNewPassByText:self.text.text Type:pass_type_essay];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareToWeixin:(id)sender
{
    enum WXScene scene = WXSceneSession;
    if (sender == self.shareToFavorite) {
        scene = WXSceneFavorite;
    }
    else if (sender == self.shareToSession){
        scene = WXSceneSession;
    }
    else if (sender == self.shareToTimeline){
        scene = WXSceneTimeline;
    }
    [[WeixinShare instance] sendTextContent:self.text.text Scene:scene];
    
}
#pragma mark - delegate

#pragma mark - notify


@end
