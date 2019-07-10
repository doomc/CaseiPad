//
//  UIViewController+NavBar.h
//  Unionpay
//
//  Created by 青 秀斌 on 13-5-24.
//  Copyright (c) 2013年 成都中信联通科技有限公司. All rights reserved.
//


@interface UIViewController (NavBar)



//设置NavBar背景
- (void)setNavbarBgImage:(UIImage *)image;

//创建选项卡标题
- (void)setTitle:(NSString *)title
        subTitle:(NSString *)subTitle
   selectAtIndex:(NSInteger)selectIndex
          action:(SEL)action;

- (void)setTitleImage:(NSString *)titleUrl;


- (void)setNavTitle:(NSString *)title;

//添加搜索
- (void)setSearchWithPTitle:(NSString *)ptitle
                     action:(SEL)action;

//设置标题
- (void)setTitle:(NSString *)title
        subTitle:(NSString *)subTitle
       iconImage:(NSString *)imgUrl
          action:(SEL)action;

//设置（系统）返回
- (void)setBackButtonWithTitle:(NSString *)title;

//设置左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title
                        action:(SEL)action;
- (void)setLeftButtonWithImage:(UIImage *)image
                        hImage:(UIImage *)hImage
                        action:(SEL)action;
//设置左边按钮
- (void)setLeftButtonOneTitle:(NSString *)oneTitle
                   seconTitle:(NSString *)secondTitle
                        image:(UIImage *)image
                       himage:(UIImage *)hImage
                    oneAction:(SEL)oneAction
                 secondAction:(SEL)secondAction;
//设置左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title
                         image:(UIImage *)image
                        himage:(UIImage *)hImage
                        action:(SEL)action;

//设置右边按钮
- (void)setRightButtonWithTitle:(NSString *)title
                         action:(SEL)action;
//设置右边按钮
- (void)setRightButtonWithTitle:(NSString *)title
                           font:(UIFont *)font
                          color:(UIColor *)color
                         hColor:(UIColor *)hColor
                         action:(SEL)action;

//设置右边按钮
- (void)setRightButtonOneTitle:(NSString *)oneTitle
                    seconTitle:(NSString *)secondTitle
                         image:(UIImage *)image
                        himage:(UIImage *)hImage
                     oneAction:(SEL)oneAction
                  secondAction:(SEL)secondAction;

- (void)setRightButtonWithImage:(UIImage *)image
                         hImage:(UIImage *)hImage
                         action:(SEL)action;
- (void)setRightButtonWithImage:(UIImage *)image
                         hImage:(UIImage *)hImage
                         action:(SEL)action
                       subImage:(UIImage *)subImage
                      subhImage:(UIImage *)subHImage
                      subAction:(SEL)subAction;

@end
