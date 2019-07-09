//
//  UITextField+GHConfig.m
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "UITextField+GHConfig.h"

@implementation UITextField (GHConfig)

static const char *__configText__ = "__configText__";
- (void)setConfigText:(NSString *)configText{
    objc_setAssociatedObject(self, __configText__, configText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.textColor = [GHAppEngine colorForColorKey:configText];
}
- (NSString *)configText {
    return objc_getAssociatedObject(self, __configText__);
}

@end
