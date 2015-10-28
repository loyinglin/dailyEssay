//
//  RecordViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/16.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "RecordViewController.h"
#import "EssayDetailController.h"
#import "EssayTableViewCell.h"
#import "EssayModel.h"

#define open_str @"open_essay_detail_board"

@interface RecordViewController ()

@end

@implementation RecordViewController
{
    long myDetailIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setTitle:NSLocalizedString(@"我的日记", nil)];
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
    
    [self.tableView reloadData];
}

#pragma mark - ui

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:open_str]) {
        EssayDetailController* controller = segue.destinationViewController;
        if (controller) {
//            controller.hidesBottomBarWhenPushed = YES;
            controller.index = myDetailIndex;
        }
    }
}

- (IBAction)onNewEssay:(id)sender
{
    myDetailIndex = -1;
    [self performSegueWithIdentifier:open_str sender:self];
}

#pragma mark - delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[EssayModel instance] getEssaysCount];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EssayTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    
    Essay* essay = [[EssayModel instance] getEssayByIndex:indexPath.row];
    
    [cell viewInitWithText:essay.text Time:essay.time];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myDetailIndex = indexPath.row;
    
    [self performSegueWithIdentifier:open_str sender:self];
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - notify


@end
