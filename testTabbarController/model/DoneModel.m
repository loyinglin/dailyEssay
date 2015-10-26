//
//  DoneModel.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/26.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DoneModel.h"

@implementation DoneModel
{
    NSMutableArray<Thing*>* myDones;
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
    
    myDones = [NSMutableArray array];
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        myDones = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myDones];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
}


#pragma mark - set

- (void)addNewDone:(Thing *)item
{
    item.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    [myDones insertObject:item atIndex:0];
    [self saveCache];
}

#pragma mark - get


- (Thing *)getThingByIndex:(long)index
{
    Thing* ret;
    if (index >= 0 && index < [self getDoneCounts]) {
        ret = myDones[index];
    }
    return ret;
}

- (long)getDoneCounts
{
    return myDones.count;
}

#pragma mark - update



#pragma mark - message
@end
