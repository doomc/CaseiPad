//
//  UIView+GHBlank.h
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BlankType_NoData,
    BlankType_NoNetWork,
    BlankType_LoadFailure,
}BlankType;

@interface UIView (GHBlank)

- (void)showBlankWithImage:(nullable NSString *)image
                     title:(nullable NSString *)title
                   message:(nullable NSString *)message
                    action:(nullable void (^)(void))action
                   offsetY:(CGFloat)offsetY;
- (void)showBlankWithImage:(nullable NSString *)image
                     title:(nullable NSString *)title
                   message:(nullable NSString *)message
                    action:(nullable void (^)(void))action;

- (void)showBlankWithType:(BlankType)type
                    title:(nullable NSString *)title
                  message:(nullable NSString *)message
                   action:(nullable void (^)(void))action
                  offsetY:(CGFloat)offsetY;
- (void)showBlankWithType:(BlankType)type
                    title:(nullable NSString *)title
                  message:(nullable NSString *)message
                   action:(nullable void (^)(void))action;

- (void)dismissBlank;

//暂无数据
- (void)showBlankNoData:(nullable void (^)(void))action offsetY:(CGFloat)offsetY;
- (void)showBlankNoData:(nullable void (^)(void))action;

//网络断开
- (void)showBlankNoNetWork:(nullable void (^)(void))action offsetY:(CGFloat)offsetY;
- (void)showBlankNoNetWork:(nullable void (^)(void))action;

//加载失败
- (void)showBlankLoadFailure:(nullable void (^)(void))action offsetY:(CGFloat)offsetY;
- (void)showBlankLoadFailure:(nullable void (^)(void))action;

@end
