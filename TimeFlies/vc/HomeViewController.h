//
//  FirstViewController.h
//  testTabbarController
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic , strong) IBOutlet UILabel* myBirthDay;

@property (nonatomic , strong) IBOutlet UILabel* myDeadDay;

@property (nonatomic , strong) IBOutlet UILabel* myDay;

@property (nonatomic , strong) IBOutlet UILabel* mySecond;

@property (nonatomic , strong) IBOutlet UIImageView* img;

@property (nonatomic , strong) IBOutlet UISlider* valueSlider;

@property (nonatomic , strong) IBOutlet UIView* knobPlaceholder;
@end

