//
//  GHAppEngine.h
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/28.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUserManager.h"
#import "GHVersionManager.h"
#import "GHMapManager.h"
#import "GHStoryBoardManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHAppEngine : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nullable, nonatomic, strong) GHUserManager *userManager;
@property (nullable, nonatomic, strong) GHThemeManager *themeManager;
@property (nullable, nonatomic, strong) GHNetworkManager *networkManager;
@property (nullable, nonatomic, strong) GHNetworkManager *uploadNetworkManager;
@property (nullable, nonatomic, strong) GHMapManager *mapManager;
@property (nullable, nonatomic, strong) GHVersionManager *versionManager;
@property (nullable, nonatomic, strong) GHStoryBoardManager *storyBoardManager;

- (void)initModule;
- (void)registerModule:(id<UIApplicationDelegate>)module;
- (void)unregisterModule:(id<UIApplicationDelegate>)module;

@end

NS_ASSUME_NONNULL_END

#define APPENGINE       ((GHAppEngine *)[[UIApplication sharedApplication] delegate])
