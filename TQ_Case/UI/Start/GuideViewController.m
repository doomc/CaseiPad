//
//  GuideController.m
//  GoodInCome
//
//  Created by 宋伟 on 15/3/11.
//  Copyright (c) 2015年 KMTeam. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()


@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initScrollView{
    _contentScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(_contentScrollView.frame.size.width * i, 0, _contentScrollView.frame.size.width, _contentScrollView.frame.size.height)];
        [view setBackgroundColor:[UIColor clearColor]];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        [imageView setBackgroundColor:[UIColor whiteColor]];
        [imageView setImage:[UIImage imageNamed:[self getImageName:i]]];
        
        [view addSubview:imageView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
        [gesture setObject:@(i)];
        [view addGestureRecognizer:gesture];
        
        [_contentScrollView addSubview:view];
    }
    
    [_contentScrollView setContentSize:CGSizeMake(_contentScrollView.frame.size.width * 2, _contentScrollView.frame.size.height)];
    [_contentScrollView setBackgroundColor:[UIColor clearColor]];
    [_contentScrollView setPagingEnabled:YES];
    [_contentScrollView setBounces:NO];
    [_contentScrollView setShowsHorizontalScrollIndicator:NO];
    [_contentScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_contentScrollView];
}

- (NSString *)getImageName:(NSInteger)index{
    switch (index) {
        case 0:{
            if([XTSystem isPhoneRetina35] || [XTSystem isPad] || [XTSystem isPadRetina] || [XTSystem isDevicePad]){
                return @"img_guide_1_4";
            }
            if([XTSystem isPhoneRetina4]){
                return @"img_guide_1_5";
            }
            if([XTSystem isPhoneRetina6]){
                return @"img_guide_1_6";
            }
            if([XTSystem isPhoneRetina6Plus]){
                return @"img_guide_1_5";
            }
        }break;
        case 1:{
            if([XTSystem isPhoneRetina35] || [XTSystem isPad] || [XTSystem isPadRetina] || [XTSystem isDevicePad]){
                return @"img_guide_2_4";
            }
            if([XTSystem isPhoneRetina4]){
                return @"img_guide_2_5";
            }
            if([XTSystem isPhoneRetina6]){
                return @"img_guide_2_6";
            }
            if([XTSystem isPhoneRetina6Plus]){
                return @"img_guide_2_5";
            }
        }break;
        case 2:{
            if([XTSystem isPhoneRetina35] || [XTSystem isPad] || [XTSystem isPadRetina] || [XTSystem isDevicePad]){
                return @"img_user_guide_3_4s";
            }
            if([XTSystem isPhoneRetina4]){
                return @"img_user_guide_3_5s";
            }
            if([XTSystem isPhoneRetina6]){
                return @"img_user_guide_3_6";
            }
            if([XTSystem isPhoneRetina6Plus]){
                return @"img_user_guide_3_5s";
            }
        }break;
        case 3:{
            if([XTSystem isPhoneRetina35] || [XTSystem isPad] || [XTSystem isPadRetina] || [XTSystem isDevicePad]){
                return @"img_user_guide_4_4s";
            }
            if([XTSystem isPhoneRetina4]){
                return @"img_user_guide_4_5s";
            }
            if([XTSystem isPhoneRetina6]){
                return @"img_user_guide_4_6";
            }
            if([XTSystem isPhoneRetina6Plus]){
                return @"img_user_guide_4_5s";
            }
        }break;
    }
    return nil;
}

- (void)gestureAction:(UIGestureRecognizer *)sender{
    
    NSInteger i = [sender.object integerValue];
    if (i != 1) {
        [_contentScrollView scrollRectToVisible:CGRectMake(_contentScrollView.frame.size.width * (i + 1), 0, _contentScrollView.frame.size.width, _contentScrollView.frame.size.height) animated:YES];
    }else{
        if([self.delegate respondsToSelector:@selector(guideViewControllerDisMiss:)]){
            [self.delegate guideViewControllerDisMiss:self];
        }
    }
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


-(BOOL)shouldAutorotate
{
    return YES;
}

@end
