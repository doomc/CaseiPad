//
//  BaseAlertView.h
//  AlertViewTest
//
//  Created by sky on 2018/9/7.
//  Copyright © 2018年 rogen. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertAnimation){
    kAlertAnimationTop,
    kAlertAnimationBottom,
    kAlertAnimationFade,
    kAlertAnimationNone,
};

@interface BaseAlertView : UIView


- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view animation:(AlertAnimation)animation;

- (void)showInWindow;
- (void)showInWindowAnimation:(AlertAnimation)animation;

- (void)dismiss;
- (void)dismissWithAnimation:(AlertAnimation)animation;


@property (nonatomic, strong) UIColor *backGroundColor;

@end
