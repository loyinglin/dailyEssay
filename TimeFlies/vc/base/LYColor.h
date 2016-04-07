//
//  LYColor.h
//  Supermark
//
//  Created by 林伟池 on 15/8/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define YINGYING_COLOR_RED          0xfA595A
#define YINGYING_COLOR_GREEN        0xc6dd7f
#define YINGYING_COLOR_BLUE         0x50C0F2 
#define YINGYING_COLOR_GRAY         0xc8c9ca
#define YINGYING_COLOR_BLACK        0x595757
#define YINGYING_COLOR_LIGHT_GRAY   0xb4b4b5
#define YINGYING_COLOR_YELLOW       0xf7b52c


@interface LYColor : NSObject

@end
