//
//  NSDate+Tools.m
//  XFile
//
//  Created by 青秀斌 on 12-9-16.
//  Copyright (c) 2012年 深圳元度科技有限公司. All rights reserved.
//

#import "NSDate+Tools.h"


@implementation NSDate (Tools)

//计算自然日
- (long)naturalDaysSinceDate:(NSDate *)date{
    NSDate *tempNow = [self dateAtStartOfDay];
    NSDate *tempOld = [date dateAtStartOfDay];
    
    return [tempNow timeIntervalSinceDate:tempOld]/(60*60*24)+1;
}

//转换为 yyyy-MM-dd
- (NSString *)toYMDString{
    return [self stringWithFormate:@"yyyy-MM-dd"];
}

//转换为 yyyy-MM-dd HH:MM
- (NSString *)toYMDHMString{
    return [self stringWithFormate:@"yyyy-MM-dd HH:mm"];
}

//转换为 yyyyMMdd
- (NSString *)toYMD1String{
    return [self stringWithFormate:@"yyyyMMdd"];
}

//转换为 yyyy/MM/dd
- (NSString *)toYMD2String{
    return [self stringWithFormate:@"yyyy/MM/dd"];
}
//转换为 yyyy年MM月dd日
- (NSString *)toYMD3String{
    return [self stringWithFormate:@"yyyy年MM月dd日"];
}

//转换为 yyyy-MM
- (NSString *)toYMString{
    return [self stringWithFormate:@"yyyy-MM"];
}



//转换为 yyyy/MM
- (NSString *)toYM2String{
    return [self stringWithFormate:@"yyyy/MM"];
}
//转换为 yyyy年MM月
- (NSString *)toYM3String{
    return [self stringWithFormate:@"yyyy年MM月"];
}

//转换为 MM-dd
- (NSString *)toMDString{
    return [self stringWithFormate:@"MM-dd"];
}
//转换为 MM/dd
- (NSString *)toMD2String{
    return [self stringWithFormate:@"MM/dd"];
}
//转换为 MM月dd日
- (NSString *)toMD3String{
    return [self stringWithFormate:@"MM月dd日"];
}


//转换为 HH:SS
- (NSString *)toHSString{
    return [self stringWithFormate:@"HH:mm"];
}



- (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}



@end
