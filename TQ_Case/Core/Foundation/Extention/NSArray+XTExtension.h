//
//  NSArray+XTExtension.h
//  XTFramework
//
//  Created by Qing Xiubin on 13-8-15.
//  Copyright (c) 2013年 XT. All rights reserved.
//

@interface NSArray (XTExtension)

- (NSArray *)head:(NSUInteger)count;
- (NSArray *)tail:(NSUInteger)count;

@end


@interface NSArray (XTJson)

- (NSData *)JSONData;
- (NSString *)JSONString;

@end
