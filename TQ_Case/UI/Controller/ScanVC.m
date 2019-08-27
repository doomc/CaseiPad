//
//  ScanVC.m
//  TQ_Case
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "ScanVC.h"
#import "RecordInfoVC.h"

@interface ScanVC ()

@property (copy, nonatomic) NSString *scanImageUrl;
@property (weak, nonatomic) IBOutlet UIImageView *loadingScanImage;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end

@implementation ScanVC

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //签到中
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signingNotification) name:kNotificationSigningStatusNotification object:nil];
    
    
    //扫描成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signingNotification) name:kNotificationScanSuccessNotification object:nil];
    
    //签到成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signingNotification) name:kNotificationSignedsStatusNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.loadingLabel setHidden:YES];
    [self getCodePost];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
 
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//获取二维码
-(void)getCodePost{
    
    [self showLoadingWithMessage:@"Load..."];
    [GHNetworkManager user_getScanCodeWithUserId:[APPDELEGATE userManager].userId projectId:[APPDELEGATE userManager].projectId success:^(id info, NSString *msg) {
        [self hideLoading];
        
        self.scanImageUrl = [NSString stringWithFormat:@"%@", info[@"data"]];
        [self.loadingScanImage yy_setImageWithURL:[NSURL URLWithString:self.scanImageUrl] placeholder:nil];
        
    } failure:^(NSError *error) {
        [self hideLoading];
    }];
}



/****************************************************/
#pragma mark - NSNotificationCenter
/****************************************************/
-(void)signingNotification{
    
#warning - 签到没有去重
    //qr_consume 签到中
    if ([[ShareManager instanceManager].scanModel.method isEqualToString:@"qr_consume"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingLabel setHidden:NO];
        });
    }
        
    //获取用户信息
    if ([[ShareManager instanceManager].scanModel.method isEqualToString:@"ipad_user_info"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RecordInfoVC * userInfoVC = [RecordInfoVC new];
            userInfoVC.scanUserInfo = [ShareManager instanceManager].scanModel.param;
            userInfoVC.backName = @"RecordInfoVC";
            [self.navigationController pushViewController:userInfoVC animated:NO];
        });
    }

}




@end
