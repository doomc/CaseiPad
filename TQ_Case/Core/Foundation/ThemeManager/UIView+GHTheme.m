//
//  UIView+GHTheme.m
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "UIView+GHTheme.h"

@implementation UIView (GHTheme)

- (void)observeThemeChange {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(themeChangeAction)
                                                 name:@"GHThemeChangeNotification"
                                               object:nil];
}

- (void)unObserveThemeChange {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"GHThemeChangeNotification"
                                                  object:nil];
}

- (void)themeChangeAction {
    
}

@end
