//
//  TodoModel.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface TodoModel : BaseModel


#pragma mark - init

+ (instancetype)instance;


#pragma mark - set

- (void)addNewTodo:(NSString*)text;


- (void)modifyTodoByIndex:(long)index Text:(NSString*)text;


- (void)deleteTodoByIndex:(long)index;

#pragma mark - get

- (Thing*)getThingByIndex:(long)index;

- (long)getTodoCounts;


#pragma mark - update



#pragma mark - message

@end
