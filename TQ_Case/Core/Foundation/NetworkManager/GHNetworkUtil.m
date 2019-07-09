//
//  GHNetworkUtil.m
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "GHNetworkUtil.h"

static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

@implementation GHQueryStringPair

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

//- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding {
//    if (!self.value || [self.value isEqual:[NSNull null]]) {
//        return WQPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding);
//    } else {
//        return [NSString stringWithFormat:@"%@=%@", WQPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding), WQPercentEscapedQueryStringValueFromStringWithEncoding([self.value description], stringEncoding)];
//    }
//}
@end

static NSArray * GHQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        for (id nestedKey in dictionary.allKeys) {
            id nestedValue = [dictionary objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        int i = 0;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[%d]", key, i++], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in set) {
            [mutableQueryStringComponents addObjectsFromArray:GHQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[GHQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

NSArray * GHQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    NSArray<GHQueryStringPair *> *tempArray = GHQueryStringPairsFromKeyAndValue(nil, dictionary);
    tempArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(GHQueryStringPair * _Nonnull obj1, GHQueryStringPair   * _Nonnull obj2) {
        return [obj1.field compare:obj2.field];
    }];
    return tempArray;
}

NSString * WQQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (GHQueryStringPair *pair in GHQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

@implementation GHNetworkUtil

//请求地址
+ (NSString *)requestUrlWithUrl:(NSString *)url api:(NSString *)api {
    if (api) {
        url = [url stringByAppendingString:api];
    }
    return url;
}

//请求参数
+ (NSDictionary *)requestParamsWithApi:(NSString *)api params:(NSDictionary *)params {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
//    [tempDic setObject:@"ios" forField:@"platform"];
//    [tempDic setObject:@"v1" forField:@"apiVersion"];
//    [tempDic setObject:api forField:@"api"];
//    [tempDic setObject:APPENGINE.userManager.userId forField:@"userId"];
//    [tempDic setObject:APPENGINE.userManager.userToken forField:@"userToken"];
    if ([params isKindOfClass:[NSDictionary class]]) {
        [tempDic addEntriesFromDictionary:params];
    }
    
    //数字签名
    //TODE
    
    return tempDic;
}

+ (NSError *)filterLoginData:(id)responseObject{
    NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
    if(code == 200){
        return nil;
    }else if(code == 401){
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOutSuccessNotification object:nil];
        return nil;
    }else{
        NSInteger code = [[responseObject objectForKey:@"status_code"] integerValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        NSError *error = [NSError bussinessError:code message:message];
        return error;
    }

}


@end
