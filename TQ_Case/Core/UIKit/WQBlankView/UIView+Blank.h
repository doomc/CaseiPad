//
//  UIView+Blank.h
//  DNF
//
//  Created by Jayla on 16/2/23.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQBlankView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Blank)

/**
 显示占位图
 
 @param action 点击事件
 @param insets 边缘缩进
 @return BlankView
 */
- (WQBlankView *)showBlankWithAction:(nullable void (^)(void))action insets:(UIEdgeInsets)insets;
- (WQBlankView *)showBlankWithAction:(nullable void (^)(void))action;

/**
 移除占位图
 */
- (void)dismissBlank;
@end

NS_ASSUME_NONNULL_END

