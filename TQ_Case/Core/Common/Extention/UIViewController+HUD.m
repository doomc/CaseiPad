//
//  XTViewController+HUD.m
//  Unionpay
//
//  Created by 青 秀斌 on 13-5-24.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//

#import "UIViewController+HUD.h"

//#import "LoadingView.h"
//#import "BGLoadingView.h"


@implementation UIViewController (HUD)


//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:message];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showSuccessWithStatus:message];
}

- (void)showFailedWithMessage:(NSString *)message{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:message];
}

- (void)hideLoading{
    [SVProgressHUD dismiss];
}

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:message];
}

//Toast Methods
- (void)showToast:(NSString *)message{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD showErrorWithStatus:message];
    [OMGToast showWithText:message];
}

@end
