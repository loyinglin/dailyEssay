
//
//  ThreeViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoCollectionViewCell.h"
#import "UIViewController+TimeFliesNavigationItem.h"
#import "TimeFlies-Swift.h"
#import "TodoModel.h"

@interface TodoViewController ()

@end

#define const_todo_detail @"open_todo_detail_board"

@implementation TodoViewController
{
    long myDetailIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) controller = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"TodoModelChange" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [controller.myTodos reloadData];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self.myTodos reloadData];
    }];
    
    [self customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customView {
//    [self lySetupRightItem];
    
//    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
//
//    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    
//    self.navigationItem.backBarButtonItem = item;
    
//    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
//    
//    
//    self.navigationItem.backBarButtonItem = item;
    
}

#pragma mark - view init

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



#pragma mark - ui

- (IBAction)onSwipeLeft:(id)sender
{
    [self.tabBarController setSelectedIndex:2];
}

- (IBAction)onSwipeRight:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)onNewTodo:(id)sender
{
    myDetailIndex = -1;
    [self performSegueWithIdentifier:const_todo_detail sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:const_todo_detail]){
        SwiftTodoDetailController* controller = segue.destinationViewController;
        controller.myIndex = myDetailIndex;
    }
}


#pragma mark - delegate


- (void)lyShowEmptyTips
{
    if ([[TodoModel instance] getTodoCounts]) {
        self.myTodos.backgroundView = nil;
    }
    else{
        UILabel* messageLabel = [UILabel new];
        messageLabel.text = NSLocalizedString(@"没有待办事件，请新建", nil);
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.myTodos.backgroundView = messageLabel;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [self lyShowEmptyTips];
    return [[TodoModel instance] getTodoCounts];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ProductListCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductListCell"forIndexPath:indexPath];
//    
//    if (indexPath.row < [[CategoryDetailModel instance] getGoodsCount]) {
//        DetailGoods* goods = [[CategoryDetailModel instance] getDetailGoodsByIndex:indexPath.row];
//        [cell viewInitWith:goods];
//    }
    TodoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todo" forIndexPath:indexPath];
    Thing* item = [[TodoModel instance] getThingByIndex:indexPath.row];
    if (item) {
        [cell viewInitWith:item.startTime Text:item.text];
    }
//    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    size.width = (long)[[UIScreen mainScreen] bounds].size.width / 3 - 1;
    
    size.height = 100;
    
    return size;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    myDetailIndex = indexPath.row;
    [self performSegueWithIdentifier:const_todo_detail sender:self];
    return YES;
}
#pragma mark - notify


@end
