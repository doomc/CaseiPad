//
//  GHNetworkManager.h
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHNetworkUtil.h"
#import "NSError+GHNetwork.h"
#import "NSMutableDictionary+GHNetwork.h"


NS_ASSUME_NONNULL_BEGIN

@interface GHNetworkManager : AFHTTPSessionManager<UIApplicationDelegate>

-(instancetype)initUpload;

- (nullable NSURLSessionDataTask *)HTTP_GET:(NSString *)url action:(nullable NSString *)action
                                 parameters:(nullable void (^)(id<GHParameterDic> parameter))parameters
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError *error))failure;
- (nullable NSURLSessionDataTask *)HTTP_GET:(NSString *)url action:(nullable NSString *)action
                                 parameters:(nullable void (^)(id<GHParameterDic> parameter))parameters
                                   progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError *error))failure;

- (nullable NSURLSessionDataTask *)HTTP_POST:(NSString *)url action:(nullable NSString *)action
                                  parameters:(nullable void (^)(id<GHParameterDic> parameter))parameters
                                     success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError *error))failure;

- (nullable NSURLSessionDataTask *)HTTP_POST:(NSString *)url action:(nullable NSString *)action
                                  parameters:(nullable void (^)(id<GHParameterDic> parameter))parameters
                   constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> formData))block
                                    progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                     success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#define POST(url, api)  APPENGINE.networkManager HTTP_POST:url action:api
#define GET(url, api)  APPENGINE.networkManager HTTP_GET:url action:api
#define POST_GAME(api)  POST(URL_FOR_GAME, api)
#define POST_USER(api)  POST(URL_FOR_USER, api)
