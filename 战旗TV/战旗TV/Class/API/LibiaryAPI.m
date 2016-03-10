//
//  LibiaryAPI.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "LibiaryAPI.h"

@implementation LibiaryAPI
+ (instancetype)getInstance{
    static LibiaryAPI *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LibiaryAPI new];
      
    });
    return _instance;
}


+ (NSDictionary *)initWithFileName:(NSString *)fileName
                        extension:(NSString *)extension{
    NSString *strJSONPath =
    [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:[NSData dataWithContentsOfFile:strJSONPath]
                          options:0
                          error:nil];
    
    return dict;
}

+ (UIViewController *)viewControllerWithKey:(NSString *)key {
    NSString *strClass = @"";
    NSDictionary *dict = @{
                           @"tab_home" : @"HomeViewController",
                           @"tab_live" : @"LiveViewController",
                           @"tab_game" : @"GameViewController",
                           @"tab_me" : @"MineViewController",
                           };
    
    if (key && key.length > 0) {
        strClass = [dict objectForKey:key];
        if (strClass && strClass.length > 0) {
            UIViewController *controller = [NSClassFromString(strClass) new];
            return controller;
        }
    }
    return nil;
}

- (HTTPClient *)getHTTPClient
{
    HTTPClient  *httpClient = [HTTPClient new];
    return httpClient;
}


+ (void)httpGET:(AppURL)appUrl
  parametersUrl:(NSString *)url
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock{
    
    [[LibiaryAPI getInstance].getHTTPClient httpGET:appUrl     parametersUrl:url  headerWithUserInfo:headerWithUserInfo parameters:parameters successBlock:successBlock failureBlock:failureBlock];
    
}




+ (void)httpGET:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock
{
    [[LibiaryAPI getInstance].getHTTPClient httpGET:appUrl headerWithUserInfo:headerWithUserInfo parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

+ (void)httpPOST:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock
{
    [[LibiaryAPI getInstance].getHTTPClient httpPOST:appUrl headerWithUserInfo:headerWithUserInfo parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

@end
