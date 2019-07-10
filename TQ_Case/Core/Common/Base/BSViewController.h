//
//  BSViewController.h
//  GameHelper
//
//  Created by Jayla on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHNavigationBar.h"

@interface BSViewController : UIViewController

typedef void (^LoginSuccessBlock)(void);
typedef void (^CancelLoginBlock)(void);

@property (weak, nonatomic) IBOutlet GHNavigationBar *bsNavigationBar;

//返回按钮事件
- (void)bsBackAction;
- (void)bsDissmissAction;
- (void)setCloseBackGeture:(BOOL)hidden;

- (IBAction)baseBackAction:(UIButton*)sender;

//是否登录
- (void)isLogin:(LoginSuccessBlock)successBlock cancelLogin:(CancelLoginBlock)cancelBlock;
- (UIViewController *)findViewController:(NSString*)className ;

@end
