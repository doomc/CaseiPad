//
//  BSNavigationController.m
//  GameHelper
//
//  Created by Jayla on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "BSNavigationController.h"
#import "CommonExtention.h"
#import "BSViewController.h"

@interface BSNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *photos;


@end

@implementation BSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = NO;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                             forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:RGB(230, 234, 242) size:CGSizeMake(SCREEN_WIDTH, 0.5)]];

    //标题字体
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(51, 55, 64),NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName, nil ]] ;
}

/**********************************************************************/
#pragma mark - StatusBar
/**********************************************************************/

- (BOOL)prefersStatusBarHidden {
    return [self.topViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.topViewController preferredStatusBarUpdateAnimation];
}

/**********************************************************************/
#pragma mark - UIViewControllerRotation
/**********************************************************************/

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    //开启iOS7的滑动返回效果
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    //设置返回按钮
    if([viewController respondsToSelector:@selector(bsBackAction)] && self.viewControllers.count > 1){
        [viewController setLeftButtonWithTitle:@""
                                         image:[UIImage imageNamed:@"common_navbar_back_nor"]
                                        himage:[UIImage imageNamed:@"common_navbar_back_nor"]
                                        action:@selector(bsBackAction)];
    }
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    //开启iOS7的滑动返回效果
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    if([viewControllerToPresent isKindOfClass:[BSNavigationController class]]){
        UINavigationController *navCon =  (UINavigationController *)viewControllerToPresent;
        if ([navCon viewControllers].count > 0) {
            UIViewController *rootCon = [[navCon viewControllers]objectAtIndex:0];
            //设置返回按钮
            if([rootCon respondsToSelector:@selector(bsDissmissAction)] && self.viewControllers.count > 1 ){
                [rootCon setLeftButtonWithTitle:@""
                                          image:[UIImage imageNamed:@"common_navbar_back_nor"]
                                         himage:[UIImage imageNamed:@"common_navbar_back_nor"]
                                         action:@selector(bsDissmissAction)];
            }
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count == 1) {
        return NO;
    }else{
        return !self.hiddenBack;
    }
}

////显示图片
//- (void)showEditeImageController:(NSMutableArray *)picArray index:(NSInteger)index{
//
//    NSMutableArray *currentShowArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < picArray.count; i ++) {
//        MWPhoto *mwPhoto = [MWPhoto photoWithURL:[NSURL URLWithString:[picArray objectAtIndex:i]]];
//        [currentShowArray addObject:mwPhoto];
//    }
//    self.photos = [NSMutableArray arrayWithArray:currentShowArray];
//
//    MWPhotoBrowser *browserEdit = [[MWPhotoBrowser alloc] initWithDelegate:self];
//    browserEdit.displayActionButton = YES;
//    browserEdit.displayNavArrows = YES;
//    browserEdit.displaySelectionButtons = NO;
//    browserEdit.alwaysShowControls = NO;
//    browserEdit.zoomPhotosToFill = YES;
//    browserEdit.enableGrid = NO;
//    browserEdit.startOnGrid = NO;
//    browserEdit.enableSwipeToDismiss = YES;
//    [browserEdit setCurrentPhotoIndex:index];
//
//    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:browserEdit];
//
//    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIViewController *controller = appdelegate.window.rootViewController;
//    [controller presentViewController:navController animated:YES completion:nil];
//}
//
///**********************************************************************/
//#pragma mark MWPhotoBrowser Delegate
///**********************************************************************/
//
//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
//    return _photos.count;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    if (index < _photos.count){
//        return [_photos objectAtIndex:index];
//    }
//    return nil;
//}


@end
