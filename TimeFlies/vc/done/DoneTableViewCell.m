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
    UILabel* timeLabel;
    UILabel* textLabel;

        timeLabel = self.myLeftText;
        textLabel = self.myRightText;
//    }
//    else{
//        timeLabel = self.myRightText;
//        textLabel = self.myLeftText;
//    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];

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
