//
//  HomeModel.m
//  TimeFlies
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
{
    NSDate* myBirthDate;
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
    
    myBirthDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSettingChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:nil];
    
    
    [self loadCache];
    
    return self;
}

-(void)onSettingChange:(NSNotification*)notify{
    
    NSInteger reason = [[notify.userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey] integerValue];
    
    NSLog(@"keyValueStoreChange %ld", reason);
    if (reason == NSUbiquitousKeyValueStoreQuotaViolationChange) {
        NSLog(@"store not enough");
    }
    
    [self loadCache];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelChange" object:nil];

}

- (void)loadCache
{
//    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
//    if (data) {
//        myBirthDate = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    }
    
    
    NSData* data = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:[[self class] description]];
    if (data) {
        myBirthDate = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myBirthDate];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUbiquitousKeyValueStore defaultStore] setObject:data forKey:[[self class] description]];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeModelChange" object:nil];
}


#pragma mark - set

- (void)setBirthDate:(NSDate *)date
{
    if (!date) {
        date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }
    myBirthDate = date;
    [self saveCache];
}

#pragma mark - get

- (NSDate *)getBirthDate
{
    return myBirthDate;
}

- (long)getDaysLeft
{
    long ret = 0;
    
    NSDate* birth = myBirthDate;
    NSDate* now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    long elapse = [now timeIntervalSinceDate:birth];
    
    ret = MAX(ret, 365 * 70 - elapse / (24 * 3600));
    
    return ret;
}

- (long)getDaysNow
{
    long ret = 0;
    
    NSDate* birth = myBirthDate;
    NSDate* now = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    long elapse = [now timeIntervalSinceDate:birth];
    
    
    ret = MAX(ret, elapse / (24 * 3600));
    
    return ret;
}


#pragma mark - update



#pragma mark - message

@end
