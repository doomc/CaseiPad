//
//  LoginVC.m
//  TQ_Case
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "LoginVC.h"
#import "HomeVC.h"
#import "RecordInfoVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userNameTextField.text = @"admin";
    self.passwordTextField.text = @"123123";

    [self.userNameTextField addTarget:self action:@selector(userloginTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(userloginTextField:) forControlEvents:UIControlEventEditingChanged];
    
    
//    
//    //默认
//    [GHNetworkManager user_loginWithUsername:self.userNameTextField.text password:self.passwordTextField.text success:^(id info, NSString *msg) {
//    } failure:^(NSError *error) {
//
//    }];
}

-(void)userloginTextField:(UITextField *)textField{

    if (self.userNameTextField == textField) {
        
    }
    if (self.passwordTextField == textField) {
        
    }
}

//登录
- (IBAction)loginAction:(id)sender {

    if (![self.userNameTextField.text isNotBlank]) {
        [OMGToast showWithText:@"请输入用户名"];
        return;
    }
    if (![self.passwordTextField.text isNotBlank]) {
        [OMGToast showWithText:@"请输入密码"];
        return;
    }
    
    WS(weakSelf);
    [self showLoadingWithMessage:Logining];
    [GHNetworkManager user_loginWithUsername:self.userNameTextField.text password:self.passwordTextField.text success:^(id info, NSString *msg) {
        [weakSelf hideLoading];
        //创建MQ
        [[ShareManager instanceManager] creatMQ];
        
        HomeVC * controller = [HomeVC new];
        [weakSelf.navigationController pushViewController:controller animated:YES];
        
    } failure:^(NSError *error) {
        [self hideLoading];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
