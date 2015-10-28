//
//  TodoCollectionViewCell.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TodoCollectionViewCell.h"

@implementation TodoCollectionViewCell

#pragma mark - view init
- (void)viewInitWith:(NSDate *)startTime Text:(NSString *)text
{
    self.myDetail.text = text;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    
    self.myStartTime.text = [dateFormatter stringFromDate:startTime];
    
//    NSLog(@"%@init", self);
//    [self layoutIfNeeded];
}
#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify

@end
