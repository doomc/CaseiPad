//
//  GHUserManager.h
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface GHUserManager : NSObject<UIApplicationDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) BOOL isLogin;

@property (copy, nonatomic)NSString *projectId;
@property (copy, nonatomic)NSString *userId;

- (void)loginOut;



@end

