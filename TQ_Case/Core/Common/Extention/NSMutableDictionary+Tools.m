//
//  NSMutableDictionary+Tools.m
//  XFiles
//
//  Created by 青秀斌 on 13-7-27.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//

#import "NSMutableDictionary+Tools.h"


@implementation NSDictionary (Tools)

- (id)valueForField:(id)field{
    id object = [self objectForKey:field];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}

@end

@implementation NSMutableDictionary (Tools)

- (void)setValue:(id)value forField:(NSString *)field{
    if (value) {
        [self setObject:value forKey:field];
    }
//    else {
//        [self setObject:@"这是空 " forKey:field];
//    }
}

- (void)setValue:(id)value forFKField:(NSString *)field{
    if (value) {
        [self setObject:value forKey:field];
    } else {
        [self setObject:[NSNull null] forKey:field];
    }
}

- (void)setValue:(id)value forOPField:(NSString *)field{
    if (value) {
        [self setObject:value forKey:field];
    }
}

@end
