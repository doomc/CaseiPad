//
//  VersionManager.m
//  HaoChe-RentCar-iOS
//
//  Created by sky on 2017/8/25.
//  Copyright © 2017年 Chengdu MoonTeam Technology. All rights reserved.
//

#import "GHVersionManager.h"

@interface GHVersionManager ()

@property (nonatomic, assign) BOOL shownAlertController; //是否已弹出更新窗口
@property (nonatomic, assign) BOOL requestedVersion; //是否已请求数据
@property (nonatomic, strong) NSString *updateMessage;

@end

@implementation GHVersionManager

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAppVersion:) name:kAppVersionUpdateNotification object:nil];
    }
    return self;
}

- (void)updateAppVersion:(id)info{
    
    if (!self.forcedUpdate) {
        return;
    }
    WS(weakSelf);
    NSString *appID = @"1235960761";
    self.appUpdateUrl = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",appID];
    if (self.requestedVersion && !self.versionNew) {
        return;
    }
    if (self.shownAlertController) {
        return ;
    }
    //获得当前发布的版本
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //耗时的操作---获取某个应用在AppStore上的信息，更改id就行
        
        NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appID];
        NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]
                                                    encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //获得上线版本号
        NSString *version = [[[dic objectForKey:@"results"]firstObject] objectForKey:@"version"];
        NSString *updateInfo = [[[dic objectForKey:@"results"]firstObject]objectForKey:@"releaseNotes"];
        
        weakSelf.updateMessage = updateInfo;
        //获得当前版本
        NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setRequestedVersion:YES];
            //更新界面
            if (version &&![version isEqualToString:currentVersion]) {
                [weakSelf setVersionNew:YES];
                [weakSelf setUpdateMessage:updateInfo];
                [weakSelf showAlertController];
            }else{
                //已是最高版本
                NSLog(@"已经是最高版本");
                [weakSelf setVersionNew:NO];
            }
        });
    });
}

- (void)showAlertController{
    WS(weakSelf);
    //有新版本
    NSString *message = [NSString stringWithFormat:@"有新版本发布啦!\n%@",weakSelf.updateMessage];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *iTunesString = weakSelf.appUpdateUrl;
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:iTunesURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        weakSelf.shownAlertController = NO;
    }]];
    self.shownAlertController = YES;
    UIViewController *windowController = (UIViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [windowController presentViewController:alert animated:YES completion:nil];
}

@end
