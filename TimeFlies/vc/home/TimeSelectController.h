//
//  TimeSelectController.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeSelectController;
@protocol ModalViewControllerDelegate <NSObject>
-(void)dismissViewController:(TimeSelectController *)mcv;
@end

@interface TimeSelectController : UIViewController

@property (nonatomic , strong) IBOutlet UIDatePicker* myDatePicker;
@property (nonatomic , weak) id<ModalViewControllerDelegate> lyDelegate;

@end
