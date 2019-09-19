//
//  User.h
//  JinZhuang
//
//  Created by sunyi on 2019/3/16.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoustomerList,EmployeeList,ChannelModel,ScanModel,ScanUserInfo;
@interface User : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *isEnable;

@property (nonatomic, copy) NSString *dateType;
@property (nonatomic, copy) NSString *tag;

@end
@interface EmployeeList : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *faceUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *projectId;

@end

@interface CoustomerList : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *visitorId;
@property (nonatomic, copy) NSString *ownerName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *soruce;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *ageGroup;
@property (nonatomic, copy) NSString *glass;
@property (nonatomic, copy) NSString *faceUrl;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *houseType;
@property (nonatomic, copy) NSString *happenTime;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *endTime;
//判断是不是客户  如果是客户排在首位
@property (nonatomic, assign) BOOL isFirstCustomer;
@property (nonatomic, assign) BOOL isSelectAvatar;


@end

@interface ChannelModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL isSelectType;
 
@end



@interface ScanModel : NSObject

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *method;//qr_consume 扫码成功  拿到用户信息ipad_user_info
@property (nonatomic, strong) ScanUserInfo *param;

@end

@interface ScanUserInfo : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *randomNum;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *dateType;
@property (nonatomic, copy) NSString *openId;

//**************访客信息***************//
@property (nonatomic, copy) NSString *blackId;

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *glass;
@property (nonatomic, copy) NSString *faceUrl;
@property (nonatomic, copy) NSString *regFaceUrl;

@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *bkgUrl;
@property (nonatomic, copy) NSString *visitorId;
@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *cameraName;
@property (nonatomic, copy) NSString *cameraId;

@property (nonatomic, copy) NSString *happenTime;
@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *sendTime;

//客户姓名
@property (nonatomic, copy) NSString *userName;
//置业顾问
@property (nonatomic, copy) NSString *employeeName;
//到访次数
@property (nonatomic, copy) NSString *loginSize;



@end
