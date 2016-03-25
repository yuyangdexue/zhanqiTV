//
//  HTTPClient.m
//  战旗TV
//
//  Created by 于洋 on 16/2/18.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient
@synthesize operation;


- (NSString *)stringHttpUrl:(NSInteger)kUrl {
    
    NSString *strSuffix = @"";
    
    switch (kUrl) {
        case AppURL_Home:
            strSuffix = @"static/live.index/recommend-apps.json?";
            break;
        case AppURL_Banner:
            strSuffix = @"touch/apps.banner?rand=1455848328344";
            break;
        case AppURL_Live:
            strSuffix = @"static/live.hots/20-1.json";
            break;
        case AppURL_Game:
            strSuffix = @"static/game.lists/12-";
            break;
        case AppURL_GamelList:
            strSuffix = @"static/game.lives/";
            break;
        case AppURL_End:
            strSuffix = @"consultation/question";
            break;
        default:
            break;
    }
    if (strSuffix.length > 0) {
        return [NSString stringWithFormat:@"%@%@", PREFIX_URL, strSuffix];
    }
    
    return strSuffix;
}


- (void)httpGET:(AppURL)appUrl
  parametersUrl:(NSString *)url
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock{
    [self httpMethod:appUrl
       parametersUrl:url isPostMethod:NO headerWithUserInfo:headerWithUserInfo params:nil successBlock:successBlock failureBlock:failureBlock];

}

- (void)httpGET:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
     parameters:(NSDictionary *)parameters
   successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
   failureBlock:(void (^)(NSError *error))failureBlock{
    [self httpMethod:appUrl
       parametersUrl:nil isPostMethod:NO headerWithUserInfo:headerWithUserInfo params:nil successBlock:successBlock failureBlock:failureBlock];
}

- (void)httpPOST:(AppURL)appUrl
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock{
    
    [self httpMethod:appUrl
       parametersUrl:nil isPostMethod:YES headerWithUserInfo:headerWithUserInfo params:nil successBlock:successBlock failureBlock:failureBlock];
}

- (void)httpPOST:(AppURL)appUrl
   parametersUrl:(NSString *)url
headerWithUserInfo:(BOOL)headerWithUserInfo
      parameters:(NSDictionary *)parameters
    successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
    failureBlock:(void (^)(NSError *error))failureBlock{
    [self httpMethod:appUrl
       parametersUrl:url isPostMethod:YES headerWithUserInfo:headerWithUserInfo params:nil successBlock:successBlock failureBlock:failureBlock];

}





- (void)httpMethod:(AppURL)appUrl
   parametersUrl:(NSString *)url
      isPostMethod:(BOOL)isPostMethod
headerWithUserInfo:(BOOL)headerWithUserInfo
            params:(NSDictionary *)params
      successBlock:(void (^)(int code, NSDictionary *dictResp))successBlock
      failureBlock:(void (^)(NSError *error))failureBlock {
    
    
    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",
     @"text/html", nil];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
   
    
    NSString *strUrl = [self stringHttpUrl:appUrl];
    if (url) {
        strUrl = [NSString stringWithFormat:@"%@%@",strUrl,url];
    }
    
    if (isPostMethod) {
        operation=[manager POST:strUrl
                     parameters:params
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                                NSLog(@"返回值格式不正确");
                                return;
                            }
                            
                            NSDictionary *dict = (NSDictionary *)responseObject;
                            int code = [dict intForKey:@"code"];
                             successBlock(code, dict);
                            
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failureBlock(error);
                            if ( [error code] == NSURLErrorCancelled) {
                                NSLog(@"取消网络");
                                
                            }
                            else
                            {
                                // 请求网络失败
                            }
                        }];
    } else {
        operation=[manager GET:strUrl
                    parameters:params
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           
                           if (![responseObject isKindOfClass:[NSDictionary class]]) {
                               NSLog(@"返回值格式不正确");
                               return;
                           }
                           NSDictionary *dict = (NSDictionary *)responseObject;
                           int code = [dict intForKey:@"code"];
                           successBlock(code, dict);
                           
                        
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           failureBlock(error);
                           
                           if ( [error code] == NSURLErrorCancelled) {
                               NSLog(@"取消网络");
                               
                           }
                           else
                           {
                                // 请求网络失败
                           }
                       }];
    }
    
    
    
    
    
}


@end
