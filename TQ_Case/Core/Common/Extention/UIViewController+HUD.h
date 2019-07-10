//
//  UIViewController+HUD.h
//  Unionpay
//
//  Created by 青 秀斌 on 13-5-24.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//


@interface UIViewController (HUD)

//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message;
- (void)showFailedWithMessage:(NSString *)message;
- (void)hideLoading;

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message;

//Toast Methods
- (void)showToast:(NSString *)message;

@end
