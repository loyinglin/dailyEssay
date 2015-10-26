//
//  DataClass.m
//  testTabbarController
//
//  Created by 林伟池 on 15/10/25.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DataClass.h"
#import <objc/runtime.h>

@implementation LYCoding

- (id)copyWithZone:(NSZone *)zone
{
    id ret = [[[self class] allocWithZone:zone] init];
    
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        NSObject<NSCopying> *	tempValue = [self valueForKey:propertyName];
        if (tempValue) {
            id value = [tempValue copy];
            [ret setValue:value forKey:propertyName];
        }
    }
    
    return ret;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        NSObject *	tempValue = [self valueForKey:propertyName];
        //        [tempValue conformsToProtocol:@protocol(NSCoding)];
        [coder encodeObject:tempValue forKey:propertyName];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int		propertyCount = 0;
        objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
        
        for ( NSUInteger i = 0; i < propertyCount; i++ )
        {
            const char *	name = property_getName(properties[i]);
            NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
        }
    }
    
    return self;
}

@end


@implementation Essay


@end

@implementation Thing


@end
