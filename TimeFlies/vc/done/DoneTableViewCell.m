//
//  DoneTableViewCell.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DoneTableViewCell.h"

@implementation DoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

- (void)viewInitWithTime:(NSDate *)endTime Text:(NSString *)text
{
    long time = endTime.timeIntervalSince1970;
    UILabel* timeLabel;
    UILabel* textLabel;
    if (time % 2) {
        timeLabel = self.myLeftText;
        textLabel = self.myRightText;
    }
    else{
        timeLabel = self.myRightText;
        textLabel = self.myLeftText;
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];

    timeLabel.text = [dateFormatter stringFromDate:endTime];
    textLabel.text = text;
}

- (void)clear
{
    self.myLeftText.text = @"";
    self.myRightText.text = @"";
}
#pragma mark - ui


#pragma mark - delegate

#pragma mark - notify


@end
