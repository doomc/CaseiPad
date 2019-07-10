//
//  MainTabBarController.m
//  YouJiaZhang
//
//  Created by sky on 2017/8/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomeVC.h"
#import "LoginVC.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger currentSelect;

@property (nonatomic, strong) BSNavigationController *twoController;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutButtonAction:) name:kLoginOutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageButtonAction:) name:@"kMessageControllerNotification" object:nil];
   
    self.delegate = self;
    
//    [self initTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loginOutButtonAction:(id)sender{
    for (BSNavigationController *navController in self.viewControllers) {
        [navController popToRootViewControllerAnimated:NO];
    }
    GHUserManager * user =  [[GHUserManager  alloc]init];
    [user loginOut];
    
}

- (void)messageButtonAction:(id)sender{
    self.selectedIndex = 1;
}

- (void)initTabBarController{
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    BSNavigationController *homeNavController = [[BSNavigationController alloc]initWithRootViewController:homeVC];
    
    BSViewController *controller = [[BSViewController alloc] init];
    BSNavigationController *doorNavController = [[BSNavigationController alloc] initWithRootViewController:controller];
    self.twoController = doorNavController;
    
    LoginVC *myVC = [[LoginVC alloc] init];
    BSNavigationController *myNavController = [[BSNavigationController alloc] initWithRootViewController:myVC];
    
    
    [self setViewControllers:[NSArray arrayWithObjects:homeNavController,doorNavController,myNavController,nil]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],NSFontAttributeName,
                                                       RGB(153, 153, 153), NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],NSFontAttributeName,
                                                       RGB(72,140,249), NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    
    
    UITabBarItem *oneItem = [self.tabBar.items objectAtIndex:0];
    [oneItem setTitle:@"首页"];
    [oneItem setImage:[[UIImage imageNamed:@"img_tab_home_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [oneItem setSelectedImage:[[UIImage imageNamed:@"img_tab_home_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *twoItem = [self.tabBar.items objectAtIndex:1];
    [twoItem setTitle:@"开门"];
    [twoItem setImageInsets:UIEdgeInsetsMake(-8, 0, 8, 0)];
    [twoItem setImage:[[UIImage imageNamed:@"img_tab_door_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [twoItem setSelectedImage:[[UIImage imageNamed:@"img_tab_door_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [twoItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],NSFontAttributeName,
                                  RGB(31,123,252), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [twoItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],NSFontAttributeName,
                                     RGB(31,123,252), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UITabBarItem *threeItem = [self.tabBar.items objectAtIndex:2];
    [threeItem setTitle:@"我的"];
    [threeItem setImage:[[UIImage imageNamed:@"img_tab_my_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [threeItem setSelectedImage:[[UIImage imageNamed:@"img_tab_my_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:RGB(255,255,255)]];
    self.tabBar.translucent = NO;
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
}



@end
