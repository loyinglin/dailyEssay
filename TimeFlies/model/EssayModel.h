//
//  EssayModel.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface EssayModel : BaseModel


#pragma mark - init
+(instancetype)instance;


#pragma mark - set

- (void)addNewEssay:(NSString*)text;

- (void)modifyEssay:(NSString*)text Index:(long)index;

- (void)deleteEssayByIndex:(long)index;

#pragma mark - get

- (long)getEssaysCount;

- (Essay*)getEssayByIndex:(long)index;

#pragma mark - update



#pragma mark - message

@end
