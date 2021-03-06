//
//  HomeVC.m
//  TQ_Case
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "HomeVC.h"
#import "RecordInfoVC.h"
#import "ScanVC.h"
#import "LoginVC.h"
#import "NoticePopView.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //访客到来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(visitorComeInNotification) name:kNotificationVisitorComeInNotification object:nil];

    //进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeConnect) name:@"UIApplicationDidEnterBackgroundNotification" object:nil];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [APPDELEGATE supportedInterfaceOrientations];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/****************************************************/
#pragma mark - 注销
/****************************************************/

- (IBAction)loginOutAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
        [self postNotification:kLoginOutSuccessNotification];
 
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}



/****************************************************/
#pragma mark - 访客登记
/****************************************************/
- (IBAction)visiterRegisterAction:(id)sender {

    __strong ScanVC * controller = [ScanVC new];
    [self.navigationController pushViewController:controller animated:YES];
}



/****************************************************/
#pragma mark - 信息录入
/****************************************************/
- (IBAction)infoRecordAction:(id)sender {

    __strong  RecordInfoVC * controller = [RecordInfoVC new];
    [self.navigationController pushViewController:controller animated:NO];
}


/****************************************************/
#pragma mark - 访客通知 NoticePopView
/****************************************************/
-(void)visitorComeInNotification{
    
    ScanModel * model = [ShareManager instanceManager].scanModel;
    NSLog(@"访客通知 method == %@",model.method); 
    dispatch_async( dispatch_get_main_queue(), ^{
        NoticePopView * alertView = [NoticePopView initAlertShowCustomer:model.param.userName?model.param.userName:@"老客户" visitCount:[NSString stringWithFormat:@"%@次",model.param.loginSize]   worker:model.param.employeeName?model.param.employeeName:@""  headerUrl:model.param.faceUrl confirmBlock:^(NoticePopView * _Nonnull popView) {
            [popView dismissWithAnimation:kAlertAnimationFade];
        }cancleBlock:^(NoticePopView * _Nonnull popView) {
            [popView dismissWithAnimation:kAlertAnimationBottom];
        }];
        [alertView showInWindowAnimation:kAlertAnimationTop];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (alertView) {
                [alertView dismissWithAnimation:kAlertAnimationBottom];
            }
        });
    });

 
}


//关闭MQ连接
-(void)closeConnect{
    NSLog(@"------------- 关闭连接 -------------");
    [[ShareManager instanceManager] closeMQ];
}
@end
