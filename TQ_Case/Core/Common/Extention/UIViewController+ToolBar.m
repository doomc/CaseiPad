//
//  UIViewController+ToolBar.m
//  Unionpay
//
//  Created by 青秀斌 on 13-8-26.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//

#import "UIViewController+ToolBar.h"


@implementation UIViewController (ToolBar)

//设置工具条背景
- (void)setToolbarBgImage:(UIImage *)image{
    UIToolbar *bar = self.navigationController.toolbar;
    if ([bar respondsToSelector:@selector(setBackButtonBackgroundImage:forState:barMetrics:)]) {
        [bar setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    }
}

@end
