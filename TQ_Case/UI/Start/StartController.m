//
//  StartController.m
//  LeonYangBao
//
//  Created by Sunyi on 15/7/20.
//  Copyright (c) 2015年 SiChuan Ayedu Technalagy. All rights reserved.
//

#import "StartController.h"
#import "GuideViewController.h"

@interface StartController ()<GuideViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (strong, nonatomic) BSNavigationController *LoginNavController;
@property (strong, nonatomic) GuideViewController *guideViewController;


@end

@implementation StartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/************************************************************/
#pragma mark Over Write
/************************************************************/

- (GuideViewController *)guideViewController{
    if(_guideViewController == nil){
        _guideViewController = [[GuideViewController alloc] init];
    }
    return _guideViewController;
}

/************************************************************/
#pragma mark Private Method
/************************************************************/

- (void)initData{
    BOOL showGuide = [self showUserGuide];
    if(!showGuide){
        [self autoLogin];
    }
}

- (void)autoLogin{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    if([userDefault objectForKey:kSessionDataKey]){
        NSDictionary *dataDic = [userDefault objectForKey:kSessionDataKey];
        [APPDELEGATE userManager].userId =  dataDic[@"id"];
        [APPDELEGATE userManager].projectId =  dataDic[@"projectId"];

    }else{
        [self postNotification:kOpenSystemNotification];
    }
}

- (BOOL)showUserGuide{
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *isFirst = [userDefaults objectForKey:@"isFirstLoading"];
//
//    if(![isFirst isEqualToString:[XTSystem appVersion]]){
//        [self addChildViewController:self.guideViewController];
//        self.guideViewController.view.frame = self.view.bounds;
//        self.guideViewController.delegate = self;
//        [self.view addSubview:self.guideViewController.view];
//
//        [userDefaults setValue:[XTSystem appVersion] forKey:@"isFirstLoading"];
//        [userDefaults synchronize];
//        
//        return YES;
//    }

    return NO;
}


/************************************************************/
#pragma mark GuideViewControllerDelegate
/************************************************************/

- (void)guideViewControllerDisMiss:(GuideViewController *)guideViewController{
    [self initData];
}



@end
