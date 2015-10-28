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
    NSMutableArray<PassThing*>* myPassThings;
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
    
    myPassThings = [NSMutableArray array];
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        NSMutableArray* arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(arr && arr.count > 0){
            if ([arr[0] isKindOfClass:[PassThing class]]) {
                myPassThings = arr;
            }
            else{
                for (Thing* item in arr) {
                    PassThing* pass = [self getPassByThing:item];
                    [myPassThings insertObject:pass atIndex:0];
                }
            }
        }
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:myPassThings];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoneModelChange" object:nil];
}


#pragma mark - set

- (void)addNewDone:(Thing *)item
{
    [myPassThings insertObject:[self getPassByThing:item] atIndex:0];
    [self saveCache];
}

- (void)addNewEssay:(Essay *)item
{
    PassThing* pass = [self getPassByEssay:item];
    [myPassThings insertObject:pass atIndex:0];
    [self saveCache];
}

- (void)addNewPassByText:(NSString *)text Type:(PASS_TYPE)type
{
    PassThing* pass = [PassThing new];
    pass.startTime = pass.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    pass.text = text;
    pass.passType = type;
    
    if (!pass.text) {
        pass.text = @"";
    }
    [myPassThings insertObject:pass atIndex:0];
    [self saveCache];
}
#pragma mark - get


- (PassThing*)getPassByThing:(Thing*)item
{
    PassThing* ret = [PassThing new];
    
    ret.startTime = item.startTime;
    ret.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    ret.passType = pass_type_thing;
    ret.text = item.text;
    
    if (!ret.text) {
        ret.text = @"";
    }
    
    return ret;
}


- (PassThing*)getPassByEssay:(Essay*)item
{
    PassThing* ret = [PassThing new];
    
    ret.startTime = item.time;
    ret.endTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    ret.passType = pass_type_essay;
    ret.text = item.text;
    
    if (!ret.text) {
        ret.text = @"";
    }
    
    return ret;
}



- (PassThing *)getThingByIndex:(long)index
{
    PassThing* ret;
    if (index >= 0 && index < [self getDoneCounts]) {
        ret = myPassThings[index];
    }
    return ret;
}

- (long)getDoneCounts
{
    return myPassThings.count;
}

#pragma mark - update



#pragma mark - message
@end
