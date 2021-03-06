//
//  GHThemeManager.m
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "GHThemeManager.h"

#define USERINFO_THEME_TYPE         @"USERINFO_THEME_TYPE"

@interface GHThemeManager ()
@property (nonatomic, assign) ThemeType themeType;
@end

@implementation GHThemeManager

- (instancetype)init {
    if (self = [super init]) {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSNumber *themeType = [userInfo objectForKey:USERINFO_THEME_TYPE];
        switch (themeType.integerValue) {
            case ThemeType_Night:{
                self.themeType = ThemeType_Night;
            }break;
            default:{
                self.themeType = ThemeType_Defalt;
            }break;
        }
    }
    return self;
}

/**********************************************************************/
#pragma mark - Public
/**********************************************************************/

- (void)switchToTheme:(ThemeType)themeType {
    self.themeType = themeType;
    
    [GHAppEngine loadColorConfigDic];
    [[NSNotificationCenter defaultCenter] postNotificationName:GHThemeChangeNotification object:self];
}

@end
