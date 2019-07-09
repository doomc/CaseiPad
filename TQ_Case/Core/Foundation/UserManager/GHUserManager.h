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
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSMutableArray *iconList;
@property (nonatomic, strong) NSNumber *tab1;
@property (nonatomic, strong) NSNumber *tab2;
@property (nonatomic, strong) NSNumber *tab3;
@property (nonatomic, strong) NSNumber *tab4;

@property (nonatomic, assign) BOOL needNotification;
@property (nonatomic, strong) NSDictionary *pushDictionary;

- (void)loginOut;

@end

