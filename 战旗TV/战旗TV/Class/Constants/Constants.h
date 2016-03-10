//
//  Constants.h
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import <UIColor+MCUIColorsUtils.h>
#import <UIAlertView+Block.h>
#import <UIActionSheet+Blocks.h>
#import "UIImageView+AFNetworking.h"
#import "NSDictionary+Accessors.h"
#import "MobClick.h"

#import "NSArray+BFKit.h"
#import "NSDate+BFKit.h"
#import "NSString+BFKit.h"
#import "Utilities.h"



#endif /* Constants_h */

#define DEBUG_LOG_OPEN

#ifdef DEBUG_LOG_OPEN
#define DLog(fmt, ...)                                                         \
NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

extern float kDeviceFactor;
extern float kDeviceWidth;
extern float kDeviceHeight;

#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kMarginTopHeight 64
#define kTabBarHeight 49

#define PREFIX_URL @"http://www.zhanqi.tv/api/"//正式
#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"
//#define HLS_URL @"http://vod.cdn.zhanqi.tv/hls/review/"
//#define HLS_URL @"http://wshls.cdn.zhanqi.tv/zqlive/"
//#define HLS_URL @"http://lxhls.cdn.zhanqi.tv/zqlive"

#define kColor_Main_Color  [UIColor colorWithHexRGB:0x589FF5]

typedef NS_ENUM(int, AppURL) {
    AppURL_Start = 1000, // URL enum 起点
    AppURL_Banner,
    AppURL_Home,
    AppURL_Live,
    AppURL_Game,
    AppURL_GamelList,
    
    
    AppURL_End // URL enum 结束点
};











