//
//  EssayModel.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "EssayModel.h"

@implementation EssayModel
{
    NSMutableArray<Essay*>* myEssays;
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
    
    myEssays = [NSMutableArray array];
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        myEssays = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myEssays];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
}

#pragma mark - set

- (void)addNewEssay:(NSString *)text
{
    if (text == nil) {
        text = @"";
    }
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
