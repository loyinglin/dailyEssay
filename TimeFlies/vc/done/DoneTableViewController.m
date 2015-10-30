//
//  DoneTableViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DoneTableViewController.h"
#import "WeixinShare.h"
#import "DoneTableViewCell.h"
#import "DoneDetailController.h"
#import "DoneModel.h"

@interface DoneTableViewController ()

@end

#define const_open_done_deteail @"open_done_detail_board"

@implementation DoneTableViewController
{
    long myIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"DoneModelChange" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
    
    if (![WXApi isWXAppInstalled]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"FavoriteSuccess" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [[DoneModel instance] clearCache];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:const_open_done_deteail]) {
        DoneDetailController* controller = segue.destinationViewController;
        controller.myIndex = myIndex;
    }
}

- (IBAction)onSave:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"分享到微信收藏", nil) message:NSLocalizedString(@"把时间轴所有的信息收藏到微信，同时清除时间轴的信息", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString* str = @"";
        for (int i = 0; i < [[DoneModel instance] getDoneCounts]; ++i) {
            PassThing* item = [[DoneModel instance] getThingByIndex:i];
            if (item) {
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];
                
                str = [NSString stringWithFormat:@"%@%@ -- %@\n%@\n", str, [dateFormatter stringFromDate:item.startTime], [dateFormatter stringFromDate:item.endTime], item.text];
            }
        }
        
        [[WeixinShare instance] sendTextContent:str Scene:WXSceneFavorite];
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [[DoneModel instance] getDoneCounts];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"done" forIndexPath:indexPath];
    
    PassThing* item = [[DoneModel instance] getThingByIndex:indexPath.row];
    if (item) {
        [cell viewInitWithTime:item.endTime Text:item.text];
    }
    else{
        [cell clear];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myIndex = indexPath.row;
    [self performSegueWithIdentifier:const_open_done_deteail sender:self];
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
