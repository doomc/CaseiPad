//
//  NSString+Tools.m
//  XFilesPro
//
//  Created by Qing Xiubin on 14-1-20.
//  Copyright (c) 2014年 深圳元度科技有限公司. All rights reserved.
//

#import "NSString+Tools.h"


@implementation NSString (Tools)

- (NSString *)removeEmoji {
    __block NSMutableString* temp = [NSMutableString string];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                              const unichar hs = [substring characterAtIndex: 0];
                              
                              // surrogate pair
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  const unichar ls = [substring characterAtIndex: 1];
                                  const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                  
                                  [temp appendString: (0x1d000 <= uc && uc <= 0x1f77f)? @"": substring]; // U+1D000-1F77F
                                  
                                  // non surrogate
                              } else {
                                  [temp appendString: (0x2100 <= hs && hs <= 0x26ff)? @"": substring]; // U+2100-26FF
                              }
                          }];
    return temp;
}

- (NSString *)removeSepcailUnicode{
    __block NSMutableString* temp = [NSMutableString string];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                              
                              const unichar hs = [substring characterAtIndex:0];
                              
                              if (0x0000 <= hs && hs <= 0x007F) {
                                  [temp appendString:substring];
                              } else if (0x2010 <= hs && hs <=0x201f){
                                  [temp appendString:substring];
                              } else if (0x3000 <= hs && hs <= 0x303F) {
                                  [temp appendString:substring];
                              } else if (0x4E00 <= hs && hs <= 0x9FA5) {
                                  [temp appendString:substring];
                              } else if (0xFF00 <= hs && hs <=0xFF6F){
                                  [temp appendString:substring];
                              } else {
                                  DDLogError(@"不兼容字符--->%@:%x",substring,hs);
                              }
                          }];
    
    return temp;
}


- (NSString *)stringByAppendTempString:(NSString *)aString{
    if (aString.length) {
        NSString *string = [self stringByAppendingString:aString];
        return string;
    }
    return self;
}


//转换为6226 **** **** 2222
- (NSString *)toSecurityCard{
    if (self.length < 12) {
        return nil;
    }else{
        return [NSString stringWithFormat:@"%@ **** **** %@",[self substringToIndex:4],[self substringFromIndex:self.length - 4]];
    }
}

//转换为6226 2222 2222 2222 222
- (NSString *)toFormateCard{
    NSMutableString *tempNumber = [NSMutableString stringWithString:[self toThinString]];
    if (tempNumber.length<4) {
        return tempNumber;
    }
    
    NSMutableString *cardNumber = [NSMutableString string];
    while (tempNumber.length>0) {
        if (tempNumber.length>=4) {
            [cardNumber appendFormat:@"%@ ",[tempNumber substringToIndex:4]];
            [tempNumber deleteCharactersInRange:NSMakeRange(0, 4)];
        }else{
            [cardNumber appendFormat:@"%@",[tempNumber substringToIndex:tempNumber.length]];
            [tempNumber deleteCharactersInRange:NSMakeRange(0, tempNumber.length)];
        }
    }
    return cardNumber;
}

//除去空格和换行
- (NSString *)toThinString{
    NSString *tempString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return tempString;
}

- (NSString *)toTimeString{
    if (self.length >=6) {
        NSString *tempString = [NSString stringWithFormat:@"%@年%@月",[self substringToIndex:4],[self substringWithRange:NSMakeRange(4, 2)]];
        return tempString;
    }else{
        return @"";
    }
}

- (NSString *)toPhoneSecret{
    if (self.length > 7) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        return self;
    }
}

- (NSString *)appendingString:(NSString *)string{
    if (string.length > 0) {
        return [self appendingString:string withTag:nil];
    }else{
        return self;
    }
}

- (NSString *)appendingString:(NSString *)string withTag:(NSString *)tagString{
    if (string.length > 0) {
        if (tagString.length > 0) {
            return [self stringByAppendingString:[NSString stringWithFormat:@"%@%@",string,tagString]];
        }else{
            return [self stringByAppendingString:string];
        }
    }else{
        return self;
    }
}

- (NSString *)toWeekString:(NSString *)week{
    NSString *str;
    if ([@"7" isEqualToString:week]) {
        str = @"星期日";
    } else if ([@"1" isEqualToString:week]) {
        str = @"星期一";
    } else if ([@"2" isEqualToString:week]) {
        str = @"星期二";
    } else if ([@"3" isEqualToString:week]) {
        str = @"星期三";
    } else if ([@"4" isEqualToString:week]) {
        str = @"星期四";
    } else if ([@"5" isEqualToString:week]) {
        str = @"星期五";
    } else if ([@"6" isEqualToString:week]) {
        str = @"星期六";
    }
    return str;
}


- (BOOL)isNumberInput:(NSString *)string{
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:string]) {
        return YES;
    }
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@""]) {
        return YES;
    }
    return NO;
//    if([string isEqualToString:@"0"] ||[string isEqualToString:@"1"] ||[string isEqualToString:@"2"] ||[string isEqualToString:@"3"] ||[string isEqualToString:@"4"] ||[string isEqualToString:@"5"] ||[string isEqualToString:@"6"] ||[string isEqualToString:@"7"] ||[string isEqualToString:@"8"] ||[string isEqualToString:@"9"] || [string isEqualToString:@""] ||[string isEqualToString:@"\n"] || [string isEqualToString:@""]){
//        
//        NSRange range = [self rangeOfString:@"0" options:NSLiteralSearch];
//        if (self.length == 1 && range.length>0 && (![string isEqualToString:@""] && ![string isEqualToString:@"\n"])){
//            return NO;
//        }
//        return YES;
//    }else{
//        return NO;
//    }
}

- (BOOL)isMoneyInput:(NSString *)string{
    
    
    return [self isMoneyInput:string point:0];
}

- (BOOL)isMoneyInput:(NSString *)string point:(NSInteger)length{
    
    if([string isEqualToString:@"0"] ||[string isEqualToString:@"1"] ||[string isEqualToString:@"2"] ||[string isEqualToString:@"3"] ||[string isEqualToString:@"4"] ||[string isEqualToString:@"5"] ||[string isEqualToString:@"6"] ||[string isEqualToString:@"7"] ||[string isEqualToString:@"8"] ||[string isEqualToString:@"9"] ||[string isEqualToString:@"\n"] || [string isEqualToString:@""] || [string isEqualToString:@"."]){
        
        if ([string isEqualToString:@"\n"] || [string isEqualToString:@""]) {
            return YES;
        }
        
        
        if (self.length == 1 &&[self isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
            return NO;
        }
        
        if (length <= 0) {
            if(([string isEqualToString:@"0"] && [self length] == 0) || [string isEqualToString:@"."]){
                return NO;
            }
        }else{
            if([string isEqualToString:@"0"]){
                NSRange range = [self rangeOfString:@"0" options:NSLiteralSearch];
                if (range.length>0 && self.length == 1){
                    return NO;
                }
            }
            if([string isEqualToString:@"."] && [self length] == 0){
                return NO;
            }
            NSRange range = [self rangeOfString:@"." options:NSLiteralSearch];
            if([string isEqualToString:@"."] && range.length>0){
                return NO;
            }
            if(range.length>0){
                if([self substringFromIndex:range.location].length <= length){
                    return YES;
                }
                return NO;
            }
        }
        return YES;
    }
    return NO;
}



@end
