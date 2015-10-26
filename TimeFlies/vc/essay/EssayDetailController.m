//
//  EssayDetailControllerViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayDetailController.h"
#import "EssayModel.h"
#import "WeixinShare.h"

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
        [[EssayModel instance] modifyEssay:self.text.text Index:self.index];
    }
    else{
        [[EssayModel instance] addNewEssay:self.text.text];
    }
    
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
