//
//  EssayTableViewCell.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssayTableViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* text;
@property (nonatomic , strong) IBOutlet UILabel* time;

- (void)viewInitWithText:(NSString*)text Time:(NSDate*)time;

@end
