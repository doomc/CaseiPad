//
//  GHUserManager.m
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "GHUserManager.h"

@interface GHUserManager ()


@end

@implementation GHUserManager

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)loginOut{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kSessionDataKey];
    [self setIsLogin:NO];
    [self setUser:nil];
    [self setProjectId:nil];
    [self setUserId:nil];
    [[ShareManager instanceManager] closeMQ];
    [[NSNotificationCenter defaultCenter] removeObserver:self];


}



@end


