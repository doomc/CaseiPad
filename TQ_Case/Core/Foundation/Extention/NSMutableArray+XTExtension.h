//
//  NSMutableArray+XTExtension.h
//  BlackRose
//
//  Created by Qing Xiubin on 14-2-16.
//  Copyright (c) 2014年 BR. All rights reserved.
//

@interface NSMutableArray (XTExtension)

- (NSMutableArray *)pushHead:(NSObject *)obj;
- (NSMutableArray *)popHead;

- (NSMutableArray *)pushHeads:(NSArray *)all;
- (NSMutableArray *)popHeads:(NSUInteger)n;

- (NSMutableArray *)pushTail:(NSObject *)obj;
- (NSMutableArray *)popTail;

- (NSMutableArray *)pushTails:(NSArray *)all;
- (NSMutableArray *)popTails:(NSUInteger)n;

- (NSMutableArray *)keepHead:(NSUInteger)n;
- (NSMutableArray *)keepTail:(NSUInteger)n;

- (id)objectAtIndexTemp:(NSUInteger)n;

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;

@end
