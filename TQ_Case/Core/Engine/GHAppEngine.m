//
//  GHAppEngine.m
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/28.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "GHAppEngine.h"
#import <UserNotifications/UserNotifications.h>

#ifdef DEBUG
const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface GHAppEngine ()
@property (nonatomic, strong) NSMutableArray<id<UIApplicationDelegate>> *modules;
@end

@implementation GHAppEngine

/**********************************************************************/
#pragma mark - Init
/**********************************************************************/

- (instancetype)init {
    if (self = [super init]) {
        [MagicalRecord setupAutoMigratingCoreDataStack];
        self.modules = [NSMutableArray new];
        
        //控制台日志
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        //文件日志
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 24; // 10s写一次
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;//log 文件最多允许 7个
        [DDLog addLogger:fileLogger];
        
        [self initModule];
    }
    return self;
}

/**********************************************************************/
#pragma mark - Public
/**********************************************************************/

- (void)initModule {
    GHUserManager *userManager = [[GHUserManager alloc] init];
    self.userManager = userManager;
    GHThemeManager *themeManager = [[GHThemeManager alloc] init];
    self.themeManager = themeManager;
    GHNetworkManager *networkManager = [[GHNetworkManager alloc] init];
    self.networkManager = networkManager;
    GHNetworkManager *uploadManager = [[GHNetworkManager alloc] initUpload];
    self.uploadNetworkManager = uploadManager;
    GHMapManager *mapManager = [[GHMapManager alloc] init];
    self.mapManager = mapManager;
    GHVersionManager *versionManger = [[GHVersionManager alloc] init];
    self.versionManager = versionManger;
    GHStoryBoardManager *sbManager = [[GHStoryBoardManager alloc] init];
    self.storyBoardManager = sbManager;
}

- (void)registerModule:(id<UIApplicationDelegate>)module {
    if (!module) {
        return;
    }
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
        DDLogInfo(@"已注册 %@", module);
    }
}

- (void)unregisterModule:(id<UIApplicationDelegate>)module {
    if (!module) {
        return;
    }
    if ([self.modules containsObject:module]) {
        [self.modules removeObject:module];
        DDLogInfo(@"已卸载 %@", module);
    }
}

@end
