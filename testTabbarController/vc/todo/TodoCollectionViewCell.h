//
//  TodoCollectionViewCell.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) IBOutlet UILabel* myStartTime;
@property (nonatomic , strong) IBOutlet UILabel* myDetail;

- (void)viewInitWith:(NSDate*)startTime Text:(NSString*)text;

@end
