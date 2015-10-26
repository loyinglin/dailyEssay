//
//  EssayTableViewCell.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayTableViewCell.h"

@implementation EssayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

- (void)viewInitWithText:(NSString *)text Time:(NSDate *)time
{
    self.text.text = text;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];

    
    self.time.text = [dateFormatter stringFromDate:time];
}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
