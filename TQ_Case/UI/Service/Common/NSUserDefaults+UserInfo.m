//
//  NSUserDefaults+UserInfo.m
//  ZrtCRM
//
//  Created by Qing Xiubin on 13-7-8.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

#import "NSUserDefaults+UserInfo.h"


@implementation NSUserDefaults (UserInfo)

//ID
- (void)setUserID:(NSString *)userID{
    if (userID) {
        [self setObject:userID forKey:@"USER_ID"];
    }else{
        [self removeObjectForKey:@"USER_ID"];
    }
    [self synchronize];
}
- (NSString *)getUserID{
    return [self objectForKey:@"USER_ID"];
}

//用户账户
- (void)setUserName:(NSString *)userName{
    if (userName) {
        [self setObject:userName forKey:@"USER_USERNAME"];
    }else{
        [self removeObjectForKey:@"USER_USERNAME"];
    }
    [self synchronize];
}
- (NSString *)getUserName{
    return [self objectForKey:@"USER_USERNAME"];
}

//用户密码
- (void)setPassword:(NSString *)password{
    if (password) {
        [self setObject:password forKey:@"USER_PASSWORD"];
    }else{
        [self removeObjectForKey:@"USER_PASSWORD"];
    }
    [self synchronize];
}
- (NSString *)getPassword{
    return [self objectForKey:@"USER_PASSWORD"];
}

//PactetToken
- (void)setPacketToken:(NSString *)packetToken{
    if(packetToken){
        [self setObject:packetToken forKey:@"USER_PACKETTOKEN"];
    }else{
        [self removeObjectForKey:@"USER_PACKETTOKEN"];
    }
    [self synchronize];
}
- (NSString *)getPacketToken{
    return [self objectForKey:@"USER_PACKETTOKEN"];
}

//deviceID
- (void)setDeviceID:(NSString *)deviceID{
    if(deviceID){
        [self setObject:deviceID forKey:@"USER_DEVICEID"];
    }else{
        [self removeObjectForKey:@"USER_DEVICEID"];
    }
    [self synchronize];
}
- (NSString *)getDeviceID{
    return [self objectForKey:@"USER_DEVICEID"];
}

//deviceID
- (void)setDevicePushID:(NSString *)deviceID{
    if(deviceID){
        [self setObject:deviceID forKey:@"USER_PUSHDEVICEID"];
    }else{
        [self removeObjectForKey:@"USER_PUSHDEVICEID"];
    }
    [self synchronize];
}

- (NSString *)getDevicePushID{
    return [self objectForKey:@"USER_PUSHDEVICEID"];
}


//voiceName
- (void)setVoiceName:(NSString *)voiceName{
    if(voiceName){
        [self setObject:voiceName forKey:@"USER_voiceName"];
    }else{
        [self removeObjectForKey:@"USER_voiceName"];
    }
    [self synchronize];
}

- (NSString *)getVoiceName{
    return [self objectForKey:@"USER_voiceName"];
}

//deviceToken
- (void)setDeviceToken:(NSString *)deviceToken{
    if(deviceToken){
        [self setObject:deviceToken forKey:@"USER_DEVICETOKEN"];
    }else{
        [self removeObjectForKey:@"USER_DEVICETOKEN"];
    }
    [self synchronize];
}
- (NSString *)getDeviceToken{
    return [self objectForKey:@"USER_DEVICETOKEN"];
}

//AutoLogin
- (void)setAutoLogin:(NSString *)autoLogin{
    if(autoLogin){
        [self setObject:autoLogin forKey:@"USER_AUTOLOGIN"];
    }else{
        [self removeObjectForKey:@"USER_AUTOLOGIN"];
    }
    [self synchronize];
}
- (NSString *)getAutoLogin{
    return [self objectForKey:@"USER_AUTOLOGIN"];
}


//Session
- (void)setSession:(NSString *)session{
    if(session){
        [self setObject:session forKey:@"USER_SESSION"];
    }else{
        [self removeObjectForKey:@"USER_SESSION"];
    }
    [self synchronize];
}
- (NSString *)getSession{
    return [self objectForKey:@"USER_SESSION"];
}

//playVideo
- (void)setPlayVideo:(NSString *)playVideo{
    if (playVideo) {
        [self setObject:playVideo forKey:@"USER_playVideo"];
    }else{
        [self removeObjectForKey:@"USER_playVideo"];
    }
    [self synchronize];
}
- (NSString *)getPlayVideo{
    return [self objectForKey:@"USER_playVideo"];
}


//shake 关闭
- (void)setShake:(NSString *)shake{
    if (shake) {
        [self setObject:shake forKey:@"USER_shake"];
    }else{
        [self removeObjectForKey:@"USER_shake"];
    }
    [self synchronize];
}
- (NSString *)getShake{
    return [self objectForKey:@"USER_shake"];
}

//CarLoanSession
- (void)setCarLoanSession:(NSString *)session{
    if(session){
        [self setObject:session forKey:@"USERCARLOAN_SESSION"];
    }else{
        [self removeObjectForKey:@"USERCARLOAN_SESSION"];
    }
    [self synchronize];
}

- (NSString *)getCarLoanSession{
    return [self objectForKey:@"USERCARLOAN_SESSION"];
}

//Switch Notification
- (void)setEnableNotification:(NSString *)enableNotification{
    if(enableNotification){
        [self setObject:enableNotification forKey:@"USER_ENABLENOTIFICATION"];
    }else{
        [self removeObjectForKey:@"USER_ENABLENOTIFICATION"];
    }
    [self synchronize];
}
- (NSString *)getEnableNotification{
    return [self objectForKey:@"USER_ENABLENOTIFICATION"];
}


//Switch PLANTFORM
- (void)setPlantform:(NSString *)planform{
    if(planform){
        [self setObject:planform forKey:@"SERVER_PLANFORM"];
    }else{
        [self removeObjectForKey:@"SERVER_PLANFORM"];
    }
    [self synchronize];
}
- (NSString *)getPlanform{
    return [self objectForKey:@"SERVER_PLANFORM"];
}


//Gesture Date
- (void)setGestureDate:(NSDate *)planform{
    if(planform){
        [self setObject:planform forKey:@"SERVER_GESRUREDATE"];
    }else{
        [self removeObjectForKey:@"SERVER_GESRUREDATE"];
    }
    [self synchronize];
}
- (NSDate *)getGestureDate{
    return [self objectForKey:@"SERVER_GESRUREDATE"];
}

- (void)setPerOneCent:(NSString *)content{
    if(content){
        [self setObject:content forKey:@"USER_OneCent"];
    }else{
        [self removeObjectForKey:@"USER_OneCent"];
    }
    [self synchronize];
}

- (NSString *)getPerOneCent{
    return [self objectForKey:@"USER_OneCent"];
}


- (void)setPerTweCent:(NSString *)content{
    if(content){
        [self setObject:content forKey:@"USER_TweCent"];
    }else{
        [self removeObjectForKey:@"USER_TweCent"];
    }
    [self synchronize];
}
- (NSString *)getPerTweCent{
    return [self objectForKey:@"USER_TweCent"];
}

//UnreadMessage
- (void)setUnreadMessage:(NSString *)content{
    if(content){
        [self setObject:content forKey:@"USER_Unread"];
    }else{
        [self removeObjectForKey:@"USER_Unread"];
    }
    [self synchronize];
}
- (NSString *)getUnreadMessage{
    return [self objectForKey:@"USER_Unread"];
}


@end


