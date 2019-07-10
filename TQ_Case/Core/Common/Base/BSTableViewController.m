//
//  BSTableViewController.m
//  GameHelper
//
//  Created by Jayla on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "BSTableViewController.h"
#import "CommonExtention.h"

@interface BSTableViewController ()

@end

@implementation BSTableViewController

- (void)dealloc {
    [self unObserveThemeChange];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self observeThemeChange];
    [self setHidesBottomBarWhenPushed:YES];
    [self.view setBackgroundColor:kBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**********************************************************************/
#pragma mark - StatusBar
/**********************************************************************/

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

/**********************************************************************/
#pragma mark - UIViewControllerRotation
/**********************************************************************/

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/**********************************************************************/
#pragma mark - OverWrite
/**********************************************************************/

- (void)themeChangeAction {
    
}

/**********************************************************************/
#pragma mark - Action
/**********************************************************************/

- (IBAction)baseBackAction:(UIButton*)sender{
    [self bsBackAction];
}

- (void)bsBackAction{
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)bsDissmissAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}




@end
