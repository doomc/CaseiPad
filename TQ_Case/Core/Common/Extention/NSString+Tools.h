//
//  NSString+Tools.h
//  XFilesPro
//
//  Created by Qing Xiubin on 14-1-20.
//  Copyright (c) 2014年 深圳元度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

- (NSString *)removeEmoji;

- (NSString *)removeSepcailUnicode;

- (NSString *)stringByAppendTempString:(NSString *)aString;

//转换为**** **** **** 2222
- (NSString *)toSecurityCard;

//转换为6226 2222 2222 2222 222
- (NSString *)toFormateCard;

- (NSString *)toTimeString;

- (NSString *)toPhoneSecret;

- (NSString *)toThinString;

- (NSString *)appendingString:(NSString *)string;

- (NSString *)appendingString:(NSString *)string withTag:(NSString *)tagString;

- (NSString *)toWeekString:(NSString *)week;

//允许输入整型
- (BOOL)isMoneyInput:(NSString *)string;

- (BOOL)isNumberInput:(NSString *)string;

- (BOOL)isMoneyInput:(NSString *)string point:(NSInteger)length;


@end
