//
//  HomeModel.h
//  TimeFlies
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

#pragma mark - init

+ (instancetype)instance;


#pragma mark - set

- (void)setBirthDate:(NSDate*)date;


#pragma mark - get

- (NSDate*)getBirthDate;

- (long)getDaysLeft;

- (long)getDaysNow;
#pragma mark - update



#pragma mark - message
@end
