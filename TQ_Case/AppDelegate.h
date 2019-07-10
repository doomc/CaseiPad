//
//  AppDelegate.h
//  TQ_Case
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GHAppEngine.h"

@interface AppDelegate : GHAppEngine <UIApplicationDelegate>

@property (nonatomic, strong) UIStoryboard *homeStoryBoard;
//支持横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;


@end

