//
//  OpenScreenController.m
//  VMoive
//
//  Created by Sunyi on 15/11/17.
//  Copyright © 2015年 Beijing VMovie Technology. All rights reserved.
//

#import "OpenScreenController.h"

@interface OpenScreenController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (assign, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *bgRoundView;

@property (strong, nonatomic) NSString *type;

@property (assign, nonatomic) BOOL showOpenContent;

@end

@implementation OpenScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.bgRoundView setCorner:19.5];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    NSLog(@"%@",[userDefaults objectForKey:@"OpenScreen_imageUrl"]);
//    
//    NSString *picUrl = [[userDefaults objectForKey:@"OpenScreen_imageUrl"] stringByReplacingOccurrencesOfString:@" "  withString:@""];
//    
//    NSString *unicodeStr = [picUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSURL *url = [NSURL URLWithString:unicodeStr];
    
//    [self.bgImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];


    self.timer = [NSTimer scheduledTimerWithTimeInterval:3// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                  target:self
                                                selector:@selector(handleTimer:)
                                                userInfo:nil
                                                 repeats:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/************************************************************/
#pragma mark Action Method
/************************************************************/

- (void)handleTimer:(id)timer{
    [self.timer invalidate];
    self.timer = nil;
    
    if([self.delegate respondsToSelector:@selector(openScreenControllerDisMis:)]){
        [self.delegate openScreenControllerDisMis:self];
    }
}

- (IBAction)scanButtonAction:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    
    if([self.delegate respondsToSelector:@selector(openScreenControllerDisMis:)]){
        [self.delegate openScreenControllerDisMis:self];
    }
}

- (IBAction)openTouchAction:(id)sender {
        
    [self.timer invalidate];
    self.timer = nil;
    
    
    if([self.delegate respondsToSelector:@selector(openScreenControllerDisMis:)]){
        [self.delegate openScreenControllerDisMis:self];
    }
}
@end
