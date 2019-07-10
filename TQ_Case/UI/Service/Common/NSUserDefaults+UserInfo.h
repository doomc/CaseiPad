//
//  NSUserDefaults+UserInfo.h
//  ZrtCRM
//
//  Created by Qing Xiubin on 13-7-8.
//  Copyright (c) 2014年 ZRT. All rights reserved.
//

@interface NSUserDefaults (UserInfo)

//ID
- (void)setUserID:(NSString *)userID;
- (NSString *)getUserID;

//用户账户
- (void)setUserName:(NSString *)userName;
- (NSString *)getUserName;

//用户密码
- (void)setPassword:(NSString *)password;
- (NSString *)getPassword;

//PactetToken
- (void)setPacketToken:(NSString *)packetToken;
- (NSString *)getPacketToken;

//deviceID
- (void)setDeviceID:(NSString *)deviceID;
- (NSString *)getDeviceID;

//deviceID
- (void)setDevicePushID:(NSString *)deviceID;
- (NSString *)getDevicePushID;

//voiceName
- (void)setVoiceName:(NSString *)voiceName;
- (NSString *)getVoiceName;


//deviceToken
- (void)setDeviceToken:(NSString *)deviceToken;
- (NSString *)getDeviceToken;

//AutoLogin
- (void)setAutoLogin:(NSString *)autoLogin;
- (NSString *)getAutoLogin;

//Session
- (void)setSession:(NSString *)session;
- (NSString *)getSession;

//CarLoanSession
- (void)setCarLoanSession:(NSString *)session;
- (NSString *)getCarLoanSession;

//playVideo
- (void)setPlayVideo:(NSString *)playVideo;
- (NSString *)getPlayVideo;

//shake
- (void)setShake:(NSString *)shake;
- (NSString *)getShake;

//Switch Notification
- (void)setEnableNotification:(NSString *)enableNotification;
- (NSString *)getEnableNotification;

//Switch PLANTFORM
- (void)setPlantform:(NSString *)planform;
- (NSString *)getPlanform;

//Gesture Date
- (void)setGestureDate:(NSDate *)planform;
- (NSDate *)getGestureDate;

- (void)setPerOneCent:(NSString *)content;
- (NSString *)getPerOneCent;

- (void)setPerTweCent:(NSString *)content;
- (NSString *)getPerTweCent;

//UnreadMessage
- (void)setUnreadMessage:(NSString *)planform;
- (NSString *)getUnreadMessage;


@end

