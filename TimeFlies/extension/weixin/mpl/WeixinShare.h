//
//  WeixinPay.h
//  Supermark
//
//  Created by 林伟池 on 15/8/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WeixinShare : NSObject<WXApiDelegate>

+(instancetype) instance;

- (void)sendPay;

- (void)sendTextContent:(NSString*)text Scene:(enum WXScene)scene;



@end
