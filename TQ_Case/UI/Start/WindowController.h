//
//  WindowController.h
//  QueenGroup
//
//  Created by Sunyi on 15/8/6.
//  Copyright (c) 2015年 Chengdu Xiaofengche Technalagy. All rights reserved.
//

#import "REFrostedViewController.h"
#import "MainTabBarController.h"
#import "StartController.h"
#import "LoginVC.h"
#import "HomeVC.h"

@interface WindowController : REFrostedViewController

@property (nonatomic, strong) StartController *startController;
@property (nonatomic, strong) LoginVC *loginController;
@property (nonatomic, strong) MainTabBarController *mainTabBarController;
@property (nonatomic, strong) HomeVC *homeController;

@property (nonatomic, strong) UIStoryboard *homeStoryBoard;

@end
