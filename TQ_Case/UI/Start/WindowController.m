//
//  WindowController.m
//  QueenGroup
//
//  Created by Sunyi on 15/8/6.
//  Copyright (c) 2015年 Chengdu Xiaofengche Technalagy. All rights reserved.
//

#import "WindowController.h"


@interface WindowController ()


@end

@implementation WindowController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib{
    BSNavigationController *startNavController = [[BSNavigationController alloc] initWithRootViewController:self.loginController];
    [startNavController setNavigationBarHidden:YES];
    self.contentViewController = startNavController;
    
    [self registerNotification:kLoginSuccessNotification object:nil selector:@selector(loginSuccessNotification:)];
    [self registerNotification:kLoginOutSuccessNotification object:nil selector:@selector(loginOutNotification:)];
    [self registerNotification:kOpenSystemNotification object:nil selector:@selector(openSystemNotification:)];
    
    [super awakeFromNib];
}


/************************************************************/
#pragma mark Over Write
/************************************************************/

- (MainTabBarController *)mainTabBarController{
    if(_mainTabBarController == nil){
        _mainTabBarController = [[MainTabBarController alloc] init];
    }
    return _mainTabBarController;
}

- (StartController *)startController{
    if(_startController == nil){
        _startController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartController"];
    }
    return _startController;
}

- (LoginVC *)loginController{
    if(_loginController == nil){
        _loginController = [[LoginVC alloc] init];
    }
    return _loginController;
}


- (HomeVC *)homeController{
    if(_homeController == nil){
        _homeController = [[HomeVC alloc] init];
    }
    return _homeController;
}

/************************************************************/
#pragma mark Notication Deal
/************************************************************/

- (void)loginSuccessNotification:(NSNotificationCenter *)notification{
    self.mainTabBarController = nil;
    self.contentViewController = self.mainTabBarController;
    _loginController = nil;
}

- (void)loginOutNotification:(NSNotificationCenter *)notification{
    [[APPENGINE userManager] loginOut];
    BSNavigationController *loginNavController = [[BSNavigationController alloc] initWithRootViewController:self.loginController];
    [loginNavController setNavigationBarHidden:YES];
    self.contentViewController = loginNavController;
    _homeController = nil;
}

//-(BOOL)shouldAutorotate
//{
//    return [[APPDELEGATE userManager] canRotation];
//}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

/************************************************************/
#pragma mark Private Method
/************************************************************/



/************************************************************/
#pragma mark Notification
/************************************************************/

- (void)openSystemNotification:(id)notification{
    BSNavigationController *loginNavController = [[BSNavigationController alloc] initWithRootViewController:self.loginController];
    [loginNavController setNavigationBarHidden:YES];
    self.contentViewController = loginNavController;
}




@end
