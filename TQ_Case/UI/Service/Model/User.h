//
//  User.h
//  JinZhuang
//
//  Created by sunyi on 2019/3/16.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoustomerList,ChannelModel;
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

@interface CoustomerList : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *faceUrl;
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

