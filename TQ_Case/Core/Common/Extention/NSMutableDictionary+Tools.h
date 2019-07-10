//
//  NSMutableDictionary+Tools.h
//  XFiles
//
//  Created by 青秀斌 on 13-7-27.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tools)

- (id)valueForField:(id)field;

@end

@interface NSMutableDictionary (Tools)

- (void)setValue:(id)value forField:(NSString *)field;
- (void)setValue:(id)value forFKField:(NSString *)field;
- (void)setValue:(id)value forOPField:(NSString *)field;

@end
