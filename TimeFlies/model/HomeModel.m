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
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        myBirthDate = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myBirthDate];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
    
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
