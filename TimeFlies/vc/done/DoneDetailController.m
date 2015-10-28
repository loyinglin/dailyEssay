//
//  DoneDetailController.m
//  TimeFlies
//
//  Created by 林伟池 on 15/10/27.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DoneDetailController.h"
#import "DoneModel.h"

@interface DoneDetailController ()

@end

@implementation DoneDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PassThing* item = [[DoneModel instance] getThingByIndex:self.myIndex];
    if (item) {
        self.myDoneDetail.text = item.text;
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

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
