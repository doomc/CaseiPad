//
//  BaseAlertView.m
//  AlertViewTest
//
//  Created by sky on 2018/9/7.
//  Copyright © 2018年 rogen. All rights reserved.
//

#import "BaseAlertView.h"

#define ALERT_TIME_DURATION     0.3f

@interface AlertController : UIViewController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

@implementation AlertController


- (void)dealloc
{
    NSLog(@"AlertController 销毁");
}


@end


@interface BaseAlertView()

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, strong) UIView *windowView;

@end

@implementation BaseAlertView

- (void)dealloc
{
    NSLog(@"BaseAlertView 销毁");
}

- (UIColor *)backGroundColor{
    if (_backGroundColor == nil) {
        _backGroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    }
    return _backGroundColor;
}

- (void)showInWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window];
}

- (void)showInWindowAnimation:(AlertAnimation)animation{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window animation:animation];
}

- (void)showInView:(UIView *)view{
    [self showInView:view animation:kAlertAnimationBottom];
}

- (void)showInView:(UIView *)view animation:(AlertAnimation)animation{
    
    [view setClipsToBounds:YES];
    [self setContentView:view];
    
    
    AlertController *viewController = [[AlertController alloc] init];
    
    self.windowView = viewController.view;
    [self.windowView setBackgroundColor:[UIColor clearColor]];
    
    [self.windowView setBackgroundColor:self.backGroundColor];
    [self.windowView setAlpha:0];
    [self.windowView setFrame:view.bounds];
    
    [view addSubview:self.windowView];

    [self.windowView addSubview:self];
    
    switch (animation) {
        case kAlertAnimationBottom:{
            [self setFrame:CGRectMake(0, self.windowView.bounds.size.height, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            [self.windowView setAlpha:0];
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setAlpha:1];
                [self setFrame:CGRectMake(0, 0, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            } completion:nil];
        }break;
        case kAlertAnimationFade:{
            [self setFrame:CGRectMake(0, 0, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            [self.windowView setAlpha:0];
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setBackgroundColor:self.backGroundColor];
                [self.windowView setAlpha:1];
            } completion:nil];
        }break;
        case kAlertAnimationTop:{
            [self setFrame:CGRectMake(0, - self.windowView.bounds.size.height, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            [self.windowView setAlpha:0];
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setBackgroundColor:self.backGroundColor];
                [self.windowView setAlpha:1];
                [self setFrame:CGRectMake(0, 0, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            } completion:nil];
        }break;
        case kAlertAnimationNone:
        default:{
            [self setFrame:CGRectMake(0, 0, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            [self.windowView setAlpha:0];
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setBackgroundColor:self.backGroundColor];
                [self.windowView setAlpha:1];
                [self setFrame:CGRectMake(0, 0, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            } completion:nil];
        }break;
    }
}

- (void)dismiss{
    [self dismissWithAnimation:kAlertAnimationBottom];

}

- (void)dismissWithAnimation:(AlertAnimation)animation{
    switch (animation) {
        case kAlertAnimationBottom:{
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setAlpha:0];
                [self setFrame:CGRectMake(0, self.windowView.bounds.size.height, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }break;
        case kAlertAnimationFade:{
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setBackgroundColor:self.backGroundColor];
                [self.windowView setAlpha:0];
                [self setCenter:self.contentView.center];
            } completion:nil];
        }break;
        case kAlertAnimationTop:{
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setAlpha:0];
                [self setFrame:CGRectMake(0, - self.windowView.bounds.size.height, self.windowView.bounds.size.width, self.windowView.bounds.size.height)];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }break;
        case kAlertAnimationNone:
        default:{
            [UIView animateWithDuration:ALERT_TIME_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.windowView setAlpha:0];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }break;
    }
}


@end
