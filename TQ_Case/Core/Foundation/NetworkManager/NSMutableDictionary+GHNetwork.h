//
//  NSMutableDictionary+GHNetwork.h
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GHParameterDic <NSObject>

- (void)setFloat:(float)value forField:(NSString *)field;
- (void)setDouble:(double)value forField:(NSString *)field;
- (void)setInteger:(NSInteger)value forField:(NSString *)field;

- (void)setObject:(id)value forField:(NSString *)field;
- (void)setObject:(id)value forEmptyField:(NSString *)field;
- (void)removeObjectForField:(NSString *)field;


//设置子参数
- (void)setParameter:(void (^)(id<GHParameterDic> parameter))block forField:(NSString *)value;
- (void)setParameterForParams:(void (^)(id<GHParameterDic> parameter))block;
@end

@interface NSMutableDictionary (GHNetwork)<GHParameterDic>



@end
