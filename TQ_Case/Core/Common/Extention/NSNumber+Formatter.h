//
//  NSNumber+Formatter.h
//  GYDirectBank
//
//  Created by 宋伟 on 14-8-19.
//  Copyright (c) 2014年 成都中联信通科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Formatter)

- (NSString *)toMoneyString2;           //1000,000.21
- (NSString *)toMoneyString3;           //1000,000.21元
- (NSString *)toMoneyString4;           //1000,000
- (NSString *)toRateString;             //利率
- (NSString *)toMoneyStringPoint:(int)point;     //232.2322(小数点后几位)
- (NSString *)toRealRateString;     

- (NSString *)toRealString;
@end
