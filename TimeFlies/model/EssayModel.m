//
//  EssayModel.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayModel.h"
#import "sqlService.h"

@implementation EssayModel
{
    NSMutableArray<Essay*>* myEssays;
    sqlService* mySqlService;
}

#define lyCloud @"iCloud.loying.lin.TimeFlies"

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
    
    myEssays = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyValueStoreChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:nil];
    
    mySqlService = [[sqlService alloc] init];
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        myEssays = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    NSArray* array = [mySqlService getTestList];
    for (sqlTestList* item in array) {
        NSLog(@"ID:%d TEXT:%@ NAME:%@", item.sqlID, item.sqlText, item.sqlname);
    }
//    NSData* data = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:[[self class] description]];
//    if (data) {
//
//        myEssays = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        NSLog(@"arr %ld", myEssays.count);
//    }
//    else{
//        NSLog(@"essay empty");
//    }
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myEssays];
    NSLog(@"size %ld", data.length);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EssayModelChange" object:nil];
    
//    [[NSUbiquitousKeyValueStore defaultStore] setObject:data forKey:[[self class] description]];
//    BOOL syn = [[NSUbiquitousKeyValueStore defaultStore] synchronize];
}

- (void)keyValueStoreChange:(NSNotification*)sender{
    NSInteger reason = [[sender.userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey] integerValue];

    NSLog(@"keyValueStoreChange %ld", reason);
    if (reason == NSUbiquitousKeyValueStoreQuotaViolationChange) {
        NSLog(@"store not enough");
    }

    [self loadCache];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EssayModelChange" object:nil];
}

#pragma mark - set

- (void)addNewEssay:(NSString *)text
{
    if (text == nil) {
        text = @"";
    }
//    for (int i = 13; i > 0; --i) {
//        text = [text stringByAppendingString:text];
//    }
    [mySqlService insertTestList:[[sqlTestList alloc] initWithID:0 Text:text Name:@"loying"]];
    Essay* item = [Essay new];
    item.text = text;
    item.time = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    [myEssays insertObject:item atIndex:0];
    
    [self saveCache];
}

- (void)modifyEssay:(NSString *)text Index:(long)index
{
    Essay* item = [self getEssayByIndex:index];
    if (item) {
        if (text == nil) {
            text = @"";
        }
        item.text = text;
        [self saveCache];
    }
}

- (void)deleteEssayByIndex:(long)index
{
    if (index >= 0 && index < myEssays.count) {
        [myEssays removeObjectAtIndex:index];
        [self saveCache];
    }
}

#pragma mark - get

- (Essay *)getEssayByIndex:(long)index
{
    Essay* ret;
    if (index >= 0 && index < myEssays.count) {
        ret = myEssays[index];
    }
    
    return ret;
}

- (long)getEssaysCount
{
    long ret = myEssays.count;
    return ret;
}

#pragma mark - update



#pragma mark - message

@end
