//
//  ThreeViewController.m
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoDetailController.h"
#import "TodoCollectionViewCell.h"
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
//    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"abc" image:[UIImage imageNamed:@"first"] selectedImage:[UIImage imageNamed:@"second"]];
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
    [self.myTodos reloadData];
    
    [super viewWillAppear:animated];

}


#pragma mark - ui


- (IBAction)onNewTodo:(id)sender
{
    myDetailIndex = -1;
    [self performSegueWithIdentifier:const_todo_detail sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:const_todo_detail]){
        TodoDetailController* controller = segue.destinationViewController;
        controller.index = myDetailIndex;
    }
}


#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
