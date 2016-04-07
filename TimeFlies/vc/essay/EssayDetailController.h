//
//  EssayDetailControllerViewController.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssayDetailController : UIViewController


@property (nonatomic , strong) IBOutlet UITextView* text;

@property (nonatomic , strong) IBOutlet UIButton* shareToSession;

@property (nonatomic , strong) IBOutlet UIButton* shareToTimeline;

@property (nonatomic , strong) IBOutlet UIButton* shareToFavorite;

@property (nonatomic , strong) IBOutlet UIButton*   attachButton;

@property (nonatomic) long index;

@end
