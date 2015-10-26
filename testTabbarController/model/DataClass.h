//
//  DataClass.h
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LYCoding : NSObject <NSCoding, NSCopying>

@end

@interface Essay : LYCoding

@property (nonatomic , strong) NSString* text;
@property (nonatomic , strong) NSDate* time;

@end

@interface Thing : LYCoding

@property (nonatomic , strong) NSDate* startTime;

@property (nonatomic , strong) NSDate* endTime;

@property (nonatomic , strong) NSString* text;

@end