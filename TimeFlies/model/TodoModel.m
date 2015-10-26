//
//  TodoModel.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "TodoModel.h"
#import "DoneModel.h"

@implementation TodoModel
{
    NSMutableArray<Thing*>* myTodos;
}

#pragma mark - init


+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}

-(instancetype)init
{
    self = [super init];
    
    myTodos = [NSMutableArray array];
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        myTodos = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myTodos];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
}


#pragma mark - set

- (void)addNewTodo:(NSString *)text
{
    if (text == nil) {
        text = @"";
    }
    
    Thing* item = [Thing new];
    item.startTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    item.text = text;
    [myTodos insertObject:item atIndex:0];
    [self saveCache];
}

- (void)modifyTodoByIndex:(long)index Text:(NSString *)text
{
    Thing* item = [self getThingByIndex:index];
    if (!text) {
        text = @"";
    }
    if (item) {
        item.text = text;
        [self saveCache];
    }
}

- (void)endTodoByIndex:(long)index
{
    Thing* item = [self getThingByIndex:index];
    if (item) {
        item.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        [myTodos removeObject:item];
        
        [[DoneModel instance] addNewDone:item];
        
        [self saveCache];
    }    
}
#pragma mark - get


- (Thing *)getThingByIndex:(long)index
{
    Thing* ret;
    if (index >= 0 && index < [self getTodoCounts]) {
        ret = myTodos[index];
    }
    return ret;
}

- (long)getTodoCounts
{
    return myTodos.count;
}

#pragma mark - update



#pragma mark - message

@end
