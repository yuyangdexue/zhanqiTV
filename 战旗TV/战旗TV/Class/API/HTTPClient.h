//
//  HTTPClient.h
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"





@interface HTTPClient : NSObject


@property (nonatomic,weak)AFHTTPRequestOperation *operation;

/**
 *  网络请求 get
 *
 *  @param appUrl             网络接口对应的appUrl
 *  @param headerWithUserInfo 是否传token uid
 *  @param parameters         网络请求参数
 *  @param successBlock       成功回调Block
 *  @param failureBlock       失败回调Block
 */

- (void)httpGET:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock;

- (void)httpGET:(AppURL)appUrl
  parametersUrl:(NSString *)url
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock;
/**
 *  网络请求 post
 *
 *  @param appUrl             网络接口对应的appUrl
 *  @param headerWithUserInfo 是否传token uid
 *  @param parameters         网络请求参数
 *  @param successBlock       成功回调Block
 *  @param failureBlock       失败回调Block
 */


- (void)httpPOST:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock;

- (void)httpPOST:(AppURL)appUrl
parametersUrl:(NSString *)url
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock;

@end
