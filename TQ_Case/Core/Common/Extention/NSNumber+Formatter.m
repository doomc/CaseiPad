//
//  NSNumber+Formatter.m
//  GYDirectBank
//
//  Created by 宋伟 on 14-8-19.
//  Copyright (c) 2014年 成都中联信通科技股份有限公司. All rights reserved.
//

#import "NSNumber+Formatter.h"

@implementation NSNumber (Formatter)


static NSNumberFormatter *numberFormatter = nil;

- (NSString *)toMoneyString2{
    NSString *numberString = [self notRounding:[self doubleValue] afterPoint:2];
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[numberString doubleValue]]];
    if (numberString.length > 0) {
        return [numberString substringFromIndex:1];
    }else{
        return @"";
    }
}
- (NSString *)toMoneyStringPoint:(int)point{
    NSString *numberString = [self notRounding:[self doubleValue] afterPoint:point];
    return numberString;
}

//四舍五入 保留小数点x位
-(NSString *)notRounding:(double)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (NSString *)toMoneyString3{
    NSString *numberString = [self notRounding:[self doubleValue] afterPoint:2];
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *money = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[numberString doubleValue]]];
    numberString = [NSString stringWithFormat:@"%@元",money];
    return numberString;
}

- (NSString *)toMoneyString4{
    NSString *numberString = [self notRounding:[self doubleValue] afterPoint:2];
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *money = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[numberString doubleValue]]];
    numberString = [NSString stringWithFormat:@"%@",money];
    
    if([numberString isEqualToString:@""]){
        numberString = @"0";
    }
    
      return numberString;
}

- (NSString *)toRateString{
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *numberValue = [numberFormatter stringFromNumber:self];
    NSRange range = [numberValue rangeOfString:@"."];
    NSString *tempValue = nil;
    if(range.length){
        tempValue = [numberValue substringFromIndex:range.location+1];
    }
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *money = [numberFormatter stringFromNumber:@([self integerValue])];
    NSString *numberString = [NSString stringWithFormat:@"%@",money];
    if(tempValue != nil){
        numberString = [numberString stringByAppendingFormat:@".%@",tempValue];
    }
    return numberString;
}

- (NSString *)toRealRateString{
    if (self == nil) {
        return @"";
    }
    NSString *numberValue = [self notRounding:[self doubleValue] afterPoint:5];
    if([numberValue isEqualToString:@"0"]){
        return @"0";
    }
    return numberValue;
}

- (NSString *)toRealString{
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    numberFormatter.numberStyle = kCFNumberFormatterSpellOutStyle;
    NSString *money = [numberFormatter stringFromNumber:self];
    return money;
}

@end
