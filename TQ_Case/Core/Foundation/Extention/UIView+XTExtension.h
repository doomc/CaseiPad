//
//  UIView+XTExtension.h
//  XTFramework
//
//  Created by Qing Xiubin on 13-8-15.
//  Copyright (c) 2013年 XT. All rights reserved.
//

@interface UIView (XTExtention)

- (instancetype)firstResponder;

+ (instancetype)viewFromXib;

@end


@interface UIView (Animation)

- (void)stopAnimation;
- (void)pauseAnimation;

@end

@interface UIView (XTLayer)

- (void)setCorner:(CGFloat)corner;
- (void)setBorder:(CGFloat)border color:(UIColor *)color;
- (void)setShadow:(CGSize)offset corner:(CGFloat)corner opacity:(CGFloat)opacity color:(UIColor *)color;

@end
