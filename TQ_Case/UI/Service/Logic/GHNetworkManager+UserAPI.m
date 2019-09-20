//
//  GHNetworkManager+User.m
//  JinZhuang
//
//  Created by sunyi on 2019/3/16.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import "GHNetworkManager+UserAPI.h"

@implementation GHNetworkManager (UserAPI)

/*
 用户登录
 */

+ (NSURLSessionDataTask *)user_loginWithUsername:(NSString *)userName
                                        password:(NSString *)password
                                         success:(void (^) (id info,NSString *msg))successBlock
                                         failure:(void (^) (NSError *error))failure{
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/user/login"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter) {
        [parameter setObject:userName forField:@"userName"];
        [parameter setObject:password forField:@"passWord"];
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            User * user = [dataDic yy_modelToJSONObject];
            [[APPDELEGATE userManager] setUser:user];
            [[APPDELEGATE userManager] setIsLogin:YES];
            [APPDELEGATE userManager].projectId = dataDic[@"projectId"];
            [APPDELEGATE userManager].userId = dataDic[@"id"];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            if (dataDic != nil) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dataDic];
                [dict removeObjectForKey:@"dateType"];
                [dict removeObjectForKey:@"tag"];

                [userDefault setObject:dict forKey:kSessionDataKey];
                [userDefault synchronize];
            }
            successBlock(dataDic,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


/*
 获取二维码
 */

+ (NSURLSessionDataTask *)user_getScanCodeWithUserId:(NSString *)userId
                                           projectId:(NSString *)projectId
                                             success:(void (^) (id info,NSString *msg))successBlock
                                             failure:(void (^) (NSError *error))failure{
   
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/qr/getQrImage"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter) {
        [parameter setObject:userId forField:@"userId"];
        [parameter setObject:projectId forField:@"projectId"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            successBlock(dataDic,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/*
 获取职业顾问列表
 */

+ (NSURLSessionDataTask *)user_getCounselorListWithprojectId:(NSString *)projectId
                                                     success:(void (^) (NSArray * customerList,NSString *msg))successBlock
                                                     failure:(void (^) (NSError *error))failure{
    
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/user/employeeList"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter) {
        [parameter setObject:projectId forField:@"projectId"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray * list = [NSArray yy_modelArrayWithClass:[EmployeeList class] json:dataDic];
            successBlock(list,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/*
 获取客户列表
 */

+ (NSURLSessionDataTask *)user_getCoustomerListWithprojectId:(NSString *)projectId
                                                     success:(void (^) (NSArray * customerList,NSString *msg))successBlock
                                                     failure:(void (^) (NSError *error))failure{
    
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/user/visitorList"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter) {
        [parameter setObject:projectId forField:@"projectId"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            
            NSArray * list = [NSArray yy_modelArrayWithClass:[CoustomerList class] json:dataDic];
            successBlock(list,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/*
 获取码表列表

 来源渠道  CHANNEL
 用户身份  USERTYPE
 物业形态  

 */

+ (NSURLSessionDataTask *)user_getCodeListWithTag:(NSString *)tag
                                          success:(void (^) (NSArray * tagList ,NSString *msg))successBlock
                                          failure:(void (^) (NSError *error))failure{
    
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/user/dictList"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter){
        
        [parameter setObject:tag forField:@"tag"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray * list = [NSArray yy_modelArrayWithClass:[ChannelModel class] json:dataDic];
            successBlock(list,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


/*
 保存访客记录
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
                                                   failure:(void (^) (NSError *error))failure{
    
    //apiRestService/addCustomer
    //visitor/mod/addVisitor
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"apiRestService/addCustomer"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter) {
        [parameter setObject:userId forField:@"id"];
        [parameter setObject:ownerName forField:@"ownerName"];
        [parameter setObject:phone forField:@"phone"];
        [parameter setObject:projectId forField:@"projectId"];
        [parameter setObject:soruce forField:@"soruce"];
        [parameter setObject:employeeId forField:@"employeeId"];
        [parameter setObject:openId forField:@"openId"];
        [parameter setObject:gender forField:@"gender"];
        [parameter setObject:ageGroup forField:@"ageGroup"];
        [parameter setObject:gender forField:@"gender"];
        [parameter setObject:glass forField:@"glass"];
        [parameter setObject:faceUrl forField:@"faceUrl"];
        [parameter setObject:userType forField:@"userType"];
        [parameter setObject:houseType forField:@"houseType"];
        [parameter setObject:happenTime forField:@"happenTime"];
        [parameter setObject:remark forField:@"remark"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            successBlock(dataDic,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 @param  projectId  项目id
 @param  employeeId  项目id
 @param  tqCustomerPo  json字符串
 "tqCustomerPo": {
    "ageRange": "5",
    "birthday": "2019-09-19",
    "sex": "1",
    "intentionLevel": "1",
    "employeeId": "00a174f7699b4807904618a7cbcd932b",
    "faceId": "2147513662",
    "customerName": "距离",
    "headPicture": "https://staticfile.tq-service.com/image/szacSystem/20190919/38b155a2dac94062a2721790cedce749.jpg",
    "knowSource": "3",
    "customerType": "1",
    "phone": "13859888788",
    "certificateNumber": "56855",
    "projectId": "26b64bb23b5145168fef7821cf62f2b1",
    "sourcePath": "3",
    "certificateType": "0"
 }
 */
+ (NSURLSessionDataTask *)user_addTqCustomerPo:(NSDictionary *)tqCustomerPo
                        tqRelationCustomersPos:(NSMutableArray *)tqRelationCustomersPos
                                    employeeId:(NSString *)employeeId
                                     projectId:(NSString *)projectId
                                       success:(void (^) (id info,NSString *msg))successBlock
                                       failure:(void (^) (ErrorsModel *error,BOOL isSuccess))failure{
    
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"apiRestService/addCustomer"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter){
        
        
        [parameter setObject:projectId forField:@"projectId"];
        [parameter setObject:employeeId forField:@"employeeId"];
        [parameter setObject:tqCustomerPo forField:@"tqCustomerPo"];
        [parameter setObject:tqRelationCustomersPos forField:@"tqRelationCustomersPos"];
        [parameter setObject:@"" forField:@"tqCustomerImgPos"];
        [parameter setObject:@"" forField:@"tqTagCustomerPos"];

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            successBlock(nil,nil);
        }else{
            BOOL isSuccess = NO;
            NSString * successCode = [NSString stringWithFormat:@"%@",responseObject[@"serviceSuccess"]];
            if ([successCode isEqualToString:@"1"]) {
                isSuccess = YES;
            }
            NSArray * errorsList = [NSArray yy_modelArrayWithClass:[ErrorsModel class] json:responseObject[@"errors"]];
            ErrorsModel * errorModel = errorsList.firstObject;
            failure(errorModel,isSuccess);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        
        BOOL isSuccess = NO;
        NSString * successCode = [NSString stringWithFormat:@"%@",responseObject[@"serviceSuccess"]];
        if ([successCode isEqualToString:@"1"]) {
            isSuccess = YES;
        }
        
        if ([successCode isEqualToString:@"1"]) {//成功
            failure(nil,isSuccess);
        }else{//失败
            NSArray * errorsList = [NSArray yy_modelArrayWithClass:[ErrorsModel class] json:responseObject[@"errors"]];
            ErrorsModel * errorModel = errorsList.firstObject;
            failure(errorModel,isSuccess);
        }
    }];
}




/*
 案场抓拍
 
 gender   1男2女
 timegroup  时间段【5min,10min,30min,60min，180min,day】
 
 */

+ (NSURLSessionDataTask *)user_catchPicWithProjectId:(NSString *)projectId
                                           timegroup:(NSString *)timegroup
                                          success:(void (^) (NSArray * list ,NSString *msg))successBlock
                                          failure:(void (^) (NSError *error))failure{
    
    return [APPENGINE.networkManager HTTP_POST:[[APPENGINE.networkManager getSERVERURL_CASE] stringByAppendingString:@"api/visitor/v1/app/query/visitorFaces"] action:@"" parameters:^(id<GHParameterDic>  _Nonnull parameter){
        
        [parameter setObject:projectId forField:@"projectId"];
        [parameter setObject:@"" forField:@"gender"];
        [parameter setObject:timegroup forField:@"timegroup"];

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [GHNetworkUtil filterLoginData:responseObject];
        if (error == nil) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray * list = [NSArray yy_modelArrayWithClass:[CoustomerList class] json:dataDic[@"list"]];
            successBlock(list,nil);
        }else{
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




@end
