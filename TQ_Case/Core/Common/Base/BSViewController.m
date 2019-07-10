//
//  BSViewController.m
//  GameHelper
//
//  Created by Jayla on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "BSViewController.h"
#import "CommonExtention.h"
#import "BSNavigationController.h"


@interface BSViewController ()

@end

@implementation BSViewController

- (void)dealloc {
    [self unObserveThemeChange];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:kBackgroundColor];
    [self observeThemeChange];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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


#pragma mark - private
- (UIViewController *)findViewController:(NSString*)className {
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}



@end
