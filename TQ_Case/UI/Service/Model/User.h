//
//  User.h
//  JinZhuang
//
//  Created by sunyi on 2019/3/16.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoustomerList;
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

@end
