//
//  BSTabBarController.m
//  GameHelper
//
//  Created by Jayla on 17/2/13.
//  Copyright © 2017年 kylincc. All rights reserved.
//

#import "BSTabBarController.h"
#import "CommonExtention.h"

@interface BSTabBarController ()

@end

@implementation BSTabBarController

/**********************************************************************/
#pragma mark - StatusBar
/**********************************************************************/

- (BOOL)prefersStatusBarHidden {
    return [self.selectedViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.selectedViewController preferredStatusBarUpdateAnimation];
}

/**********************************************************************/
#pragma mark - UIViewControllerRotation
/**********************************************************************/

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end
