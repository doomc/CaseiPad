//
//  UIView+XTExtension.m
//  XTFramework
//
//  Created by Qing Xiubin on 13-8-15.
//  Copyright (c) 2013年 XT. All rights reserved.
//

#import "UIView+XTExtension.h"

@implementation UIView (XTExtention)

- (instancetype)firstResponder{
    for (UIView *subView in self.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        UIView *tempView = [subView firstResponder];
        if (tempView != nil) {
            return tempView;
        }
    }
    return nil;
}


+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end


@implementation UIView (Animation)

- (void)stopAnimation{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    self.layer.speed= 0.0;
    self.layer.timeOffset= pausedTime;
}

- (void)pauseAnimation{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    
    self.layer.speed= 1.0;
    self.layer.timeOffset= 0.0;
    self.layer.beginTime= timeSincePause;
}

@end

@implementation UIView (XTLayer)

- (void)setCorner:(CGFloat)corner{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:corner];
}

- (void)setBorder:(CGFloat)border color:(UIColor *)color{
    [self.layer setBorderWidth:border];
    [self.layer setBorderColor:color.CGColor];
}

- (void)setShadow:(CGSize)offset corner:(CGFloat)corner opacity:(CGFloat)opacity color:(UIColor *)color{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowPath:shadowPath.CGPath];
}

@end
