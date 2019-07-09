//
//  UIViewController+GHTheme.h
//  GameHelper
//
//  Created by Jayla on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GHTheme)

- (void)observeThemeChange;
- (void)unObserveThemeChange;

- (void)themeChangeAction;

@end
