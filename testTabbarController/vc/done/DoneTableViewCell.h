//
//  DoneTableViewCell.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneTableViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* myLeftText;

@property (nonatomic , strong) IBOutlet UILabel* myRightText;

- (void)viewInitWithTime:(NSDate*)endTime Text:(NSString*)text;

- (void)clear;

@end
