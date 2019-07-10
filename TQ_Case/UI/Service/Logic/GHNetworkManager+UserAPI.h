//
//  GHNetworkManager+User.h
//  JinZhuang
//
//  Created by sunyi on 2019/3/16.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import "GHNetworkManager.h"

@interface GHNetworkManager (UserAPI)

/*
 用户登录
 */

+ (NSURLSessionDataTask *)user_loginWithUsername:(NSString *)userName
                                        password:(NSString *)password
                                         success:(void (^) (id info,NSString *msg))successBlock
                                         failure:(void (^) (NSError *error))failure;


/*
 获取二维码
 */

+ (NSURLSessionDataTask *)user_getScanCodeWithUserId:(NSString *)userId
                                           projectId:(NSString *)projectId
                                             success:(void (^) (id info,NSString *msg))successBlock
                                             failure:(void (^) (NSError *error))failure;


/*
 获取职业顾问列表
 */

+ (NSURLSessionDataTask *)user_getCounselorListWithprojectId:(NSString *)projectId
                                                     success:(void (^) (NSArray * customerList,NSString *msg))successBlock
                                             failure:(void (^) (NSError *error))failure;



/*
 获取客户列表
 */
+ (NSURLSessionDataTask *)user_getCoustomerListWithprojectId:(NSString *)projectId
                                                     success:(void (^) (NSArray * customerList,NSString *msg))successBlock
                                                     failure:(void (^) (NSError *error))failure;

/*
 获取码表列表
 */

+ (NSURLSessionDataTask *)user_getCodeListWithTag:(NSString *)tag
                                          success:(void (^) (id info,NSString *msg))successBlock
                                          failure:(void (^) (NSError *error))failure;


/**
 *   保存访客记录
 *  @param userId 用户id
 *  @param ownerName 客户姓名
 *  @param phone 客户手机号
 *  @param projectId 客户分组
 *  @param soruce  来源渠道
 *  @param employeeId 关联职业顾问
 *  @param openId  微信id
 *  @param gender 性别
 *  @param ageGroup 年龄
 *  @param glass 是否戴眼镜
 *  @param faceUrl 人脸图片
 *  @param userType 用户身份
 *  @param houseType 物业形态
 *  @param happenTime 抓拍时间
 *  @param remark   备注
 */
+ (NSURLSessionDataTask *)user_saveVisitorRecordWithUserId:(NSString *)userId
                                                 ownerName:(NSString *)ownerName
                                                     phone:(NSString *)phone
                                                 projectId:(NSString *)projectId
                                                    soruce:(NSString *)soruce
                                                employeeId:(NSString *)employeeId
                                                    openId:(NSString *)openId
                                                    gender:(NSString *)gender
                                                  ageGroup:(NSString *)ageGroup
                                                     glass:(NSString *)glass
                                                   faceUrl:(NSString *)faceUrl
                                                  userType:(NSString *)userType
                                                 houseType:(NSString *)houseType
                                                happenTime:(NSString *)happenTime
                                                    remark:(NSString *)remark
                                                   success:(void (^) (id info,NSString *msg))successBlock
                                                   failure:(void (^) (NSError *error))failure;
    

@end


