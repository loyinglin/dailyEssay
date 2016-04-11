//
//  RecordViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/16.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayViewController.h"
#import "EssayDetailController.h"
#import "EssayTableViewCell.h"
#import "TimeFlies-Swift.h"
#import "EssayModel.h"

#define open_str @"open_essay_detail_board"

@interface EssayViewController ()

@end

@implementation EssayViewController
{
    long myDetailIndex;
    BOOL myDelete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setTitle:NSLocalizedString(@"我的日记", nil)];
//    [self.tableView setEditing:YES animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    myDelete = NO;
    __weak typeof (self) controller = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"EssayModelChange" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (myDelete) { //删除有特定的动画
            return ;
        }
        [controller.tableView reloadData];
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


- (IBAction)onSwipeLeft:(id)sender
{
    [self.tabBarController setSelectedIndex:3];
}

- (IBAction)onSwipeRight:(id)sender
{
    [self.tabBarController setSelectedIndex:1];
}


#pragma mark - delegate

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"abc");
//    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
//
//        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
//
//    return result;
//}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"删除", nil);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // Delete the row from the data source.
        myDelete = YES;
        [[EssayModel instance] deleteEssayByIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        myDelete = NO;
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self lyShowEmptyTips];
    return [[EssayModel instance] getEssaysCount];
}


- (void)lyShowEmptyTips
{
    if ([[EssayModel instance] getEssaysCount]) {
        self.tableView.backgroundView = nil;
    }
    else{
        UILabel* messageLabel = [UILabel new];
        messageLabel.text = NSLocalizedString(@"没有日记，请新建", nil);
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
    }
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwiftEssayTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    
    Essay* essay = [[EssayModel instance] getEssayByIndex:indexPath.row];
    
    [cell viewInitWithText:essay.text time:essay.time];
    
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
