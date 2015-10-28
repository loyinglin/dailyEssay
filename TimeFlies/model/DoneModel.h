//
//  DoneModel.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface DoneModel : BaseModel


#pragma mark - init

+ (instancetype)instance;

#pragma mark - set
- (void)addNewDone:(Thing *)item;

- (void)addNewEssay:(Essay*)item;

- (void)addNewPassByText:(NSString*)text Type:(PASS_TYPE)type;

#pragma mark - get


- (PassThing *)getThingByIndex:(long)index;

- (long)getDoneCounts;


#pragma mark - update



#pragma mark - message

@end
