//
//  UIView+GHConfig.m
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "UIView+GHConfig.h"

@implementation UIView (GHConfig)

static const char *__configBackground__ = "__configBackground__";
- (void)setConfigBackground:(NSString *)configBackground{
    objc_setAssociatedObject(self, __configBackground__, configBackground, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.backgroundColor = [GHAppEngine colorForColorKey:configBackground];
}
- (NSString *)configBackground {
    return objc_getAssociatedObject(self, __configBackground__);
}

@end
