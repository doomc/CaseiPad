//
//  RecordInfoVC.m
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "RecordInfoVC.h"
#import "HeaderCollectionCell.h"//头
#import "UserInfoCell.h"//输入名称
#import "MenuTagCell.h"//标签
#import "RemarkCell.h"//文本
#import "PopViewController.h"
#import "HomeVC.h"

@interface RecordInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,PopViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) NSArray * titles0;
@property (strong, nonatomic) NSArray * titles1;
@property (strong, nonatomic) NSArray * titles2;

@property (copy, nonatomic) NSString *sourceType;//来源渠道
@property (copy, nonatomic) NSString *userType;//用户身份
@property (copy, nonatomic) NSString *wyType;//物业形态
@property (copy, nonatomic) NSString *remark;//备注
@property (copy, nonatomic) NSString *ownerPhone;//手机号
@property (copy, nonatomic) NSString *ownerName;//姓名
@property (copy, nonatomic) NSString *counselorId;//顾问id
@property (copy, nonatomic) NSString *customerfaceUrl;//保存

@property (strong, nonatomic) NSArray * avatarsList;//抓拍头像
@property (strong, nonatomic) NSArray * counselorList;//置业顾问
@property (strong, nonatomic) NSMutableArray * choosed;//已选客户
@property (strong, nonatomic) CoustomerList * userInfo;

@property (assign , nonatomic) CGFloat kcollectionView0Height;
@end

@implementation RecordInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.kcollectionView0Height = 226;
    //二维码自动录入
    if (self.scanUserInfo) {
        self.ownerPhone  =  self.scanUserInfo.phone;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.tableView.backgroundColor = [UIColor clearColor];
  
    WS(weakSelf);
    //获取客户列表
    [GHNetworkManager user_getCoustomerListWithprojectId:[APPDELEGATE userManager].projectId success:^(NSArray *customerList, NSString *msg) {

        weakSelf.avatarsList  = customerList;
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {

    }];

    
    [self showLoadingWithMessage:@"数据载入中..."];
    //获取关联置业顾问
    [GHNetworkManager user_getCounselorListWithprojectId:[APPDELEGATE userManager].projectId success:^(NSArray *customerList, NSString *msg) {
        if (customerList.count > 0) {
            weakSelf.counselorList  = customerList;
        }
        [self hideLoading];
    } failure:^(NSError *error) {
        [self hideLoading];
    }];

    
    //获取码表 来源渠道
    [GHNetworkManager user_getCodeListWithTag:@"CHANNEL" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles0 = tagList;
    } failure:^(NSError *error) {
    }];
    
    //用户身份
    [GHNetworkManager user_getCodeListWithTag:@"USERTYPE" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles1 = tagList;
    } failure:^(NSError *error) {
    }];
    
    //物业形态
    [GHNetworkManager user_getCodeListWithTag:@"PROPERTYTYPE" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles2 = tagList;
    } failure:^(NSError *error) {
        
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

#pragma mark  - tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    switch (indexPath.section) {
        case 0:{
            HeaderCollectionCell * cell = [HeaderCollectionCell configCell0:tableView indexPath:indexPath];
            if (self.counselorList) {
                //更新已选
                cell.selectArray = self.choosed;
                [cell reloadCollectionViewData0];
            }
            //传入抓拍客户列表
            cell.dataArray = self.avatarsList;
            cell.collectionView0ConstrainsHeight.constant = self.kcollectionView0Height;

            //加载更多
            [cell.loadingMoreButton setAction:^{
                cell.loadingMoreButton.selected = !cell.loadingMoreButton.selected;
                [weakSelf.tableView reloadData];
                if (cell.loadingMoreButton.selected) {
                    [cell.loadingMoreButton setTitle:@"点击回收" forState:UIControlStateNormal];
                    CGFloat height = cell.collectionView0.collectionViewLayout.collectionViewContentSize.height;
                    cell.collectionView0ConstrainsHeight.constant = self.kcollectionView0Height =   height > 226 ? height :226;
                    NSLog(@"sssssssssssss %.f",height);
                }else{
                    [cell.loadingMoreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
                    cell.collectionView0ConstrainsHeight.constant = self.kcollectionView0Height = 226;
                }

            }];
         
            if (self.choosed) {
                cell.selectArray = self.choosed;
                //选中的第一个客户
                CoustomerList * user = self.choosed.firstObject;
                self.customerfaceUrl = user.faceUrl;
                
                [cell reloadCollectionViewData1];
                [cell reloadCollectionViewData0];
          
            }
            cell.selectAvatarBlock = ^(NSMutableArray * _Nonnull selectArray) {
                //已选
                weakSelf.choosed = selectArray;
                [UIView performWithoutAnimation:^{
                    [weakSelf.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
            
            return cell;
        }; break;
        case 1:{//用户信息
            UserInfoCell * cell = [UserInfoCell configCell0:tableView indexPath:indexPath];
            cell.userNameTextField.text =self.ownerName;
            cell.userPhoneTextField.text =self.ownerPhone;
            cell.textFieldBlock = ^(NSString * _Nonnull name, NSString * _Nonnull phone) {
                weakSelf.ownerPhone = phone;
                weakSelf.ownerName = name;
                if (phone.length == 11 && name.length > 0) {
                    [weakSelf.commitButton setImage:[UIImage imageNamed:@"user_commit_enable"] forState:UIControlStateNormal];
                }else{
                    [weakSelf.commitButton setImage:[UIImage imageNamed:@"user_commit_disable"] forState:UIControlStateNormal];
                }
            };
            [cell.counselorNameButton setAction:^{//选择顾问
                [weakSelf showPopView:cell.counselorNameButton];
            }];
            if (self.userInfo) {
                //设置头像
                [cell.counselorAvatars yy_setImageWithURL:[NSURL URLWithString:self.userInfo.faceUrl] placeholder:nil];
                //顾问姓名
                [cell.counselorNameButton setTitle:self.userInfo.name forState:UIControlStateNormal];
            }
            
            return cell;
        }; break;
        case 2:{//来源渠道标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.isMark =@"1";
            cell.dataArray = self.titles0;
            cell.exchangeBlock = ^(NSString * _Nonnull json) {
                NSLog(@"json === %@",json);
                weakSelf.sourceType = json;
            };
            return cell;
        }; break;
        case 3:{//用户身份标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.isMark =@"1";
            cell.exchangeBlock = ^(NSString * _Nonnull json) {
                NSLog(@"json === %@",json);
                weakSelf.userType = json;
             
            };
            cell.titleLabel.text = @"用户身份";
            cell.detailLabel.text = @"（请选择用户身份，可多选！）";
            cell.dataArray = self.titles1;
            return cell;
        }; break;
        case 4:{// 物业形态标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.isMark = @"0";
            cell.titleLabel.text = @"物业形态";
            cell.detailLabel.text = @"（请选择物业形态，单选！）";
            cell.dataArray = self.titles2;
            cell.exchangeBlock = ^(NSString * _Nonnull json) {
                NSLog(@"json === %@",json);
                weakSelf.wyType = json;
            };
            return cell;
        }; break;
        case 5:{//备注信息
            RemarkCell * cell = [RemarkCell configCell0:tableView indexPath:indexPath];
            cell.textViewBlock = ^(NSString * _Nonnull remark) {
                weakSelf.remark = remark;
            };
            return cell;
        }break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:{
            return [HeaderCollectionCell configCell0HeightWithInfo:self.kcollectionView0Height];
        }; break;
        case 1:{
            return [UserInfoCell configCell0HeightWithInfo:nil];
        }; break;
        case 2:{
            return [MenuTagCell configCell0HeightWithInfo:nil];
        }; break;
        case 3:{
            return [MenuTagCell configCell0HeightWithInfo:nil];
        }; break;
        case 4:{
            return [MenuTagCell configCell0HeightWithInfo:nil];
        }; break;
        case 5:{
            return [RemarkCell configCell0HeightWithInfo:nil];
        }; break;
        default:
            break;
    }
    return 0;
}


#pragma mark  - backAction
- (IBAction)backAction:(id)sender {
 
    if ([self.backName isEqualToString:@"RecordInfoVC"]) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HomeVC class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark  - 提交信息

- (IBAction)commitAction:(id)sender {

    if (![self.ownerName isNotBlank]) {
        [OMGToast showWithText:@"姓名不能为空"];
        return;

    }
    if (![self.ownerPhone isNotBlank]) {
        [OMGToast showWithText:@"手机号不能为空"];
        return;
    }
    if (![self.counselorId isNotBlank]) {
        [OMGToast showWithText:@"请选择您的置业顾问"];
        return;
    }

    [self showLoadingWithMessage:@"正在录入信息..."];
    //保存访客列表
    [GHNetworkManager user_saveVisitorRecordWithUserId:[APPDELEGATE userManager].userId
                                              ownerName:self.ownerName
                                                  phone:self.ownerPhone
                                              projectId:[APPDELEGATE userManager].projectId
                                                 soruce:self.sourceType
                                             employeeId:self.counselorId
                                                openId:self.scanUserInfo.openId?self.scanUserInfo.openId:@""
                                                 gender:@""
                                               ageGroup:@""
                                                  glass:@""
                                                faceUrl:self.customerfaceUrl
                                               userType:self.userType
                                              houseType:self.wyType
                                             happenTime:@""//抓拍时间
                                                remark:self.remark
                                                success:^(id info, NSString *msg) {
                                                    [OMGToast showWithText:@"信息录入成功！"];
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    });
                                                    [self hideLoading];
                                                } failure:^(NSError *error) {
                                                    [self hideLoading];
                                                    [OMGToast showWithText:@"信息录入失败！"];
                                                }];

}




-(void)showPopView:(UIButton*)sender{
    
    [self showLoadingWithMessage:@"加载中..."];

    PopViewController * popVC = [PopViewController new];

    popVC.list = self.counselorList;
    
    popVC.delegate = self;

    popVC.modalPresentationStyle = UIModalPresentationPopover;
    //  1、弹出视图的大小
    popVC.preferredContentSize = CGSizeMake(216, 265);
    //  弹出视图的代理
    popVC.popoverPresentationController.delegate = self;
    //  弹出视图的参照视图、从哪弹出
    popVC.popoverPresentationController.sourceView = sender;
    //  弹出视图的尖头位置：参照视图底边中间位置
    popVC.popoverPresentationController.sourceRect = sender.bounds;
    //  弹出视图的箭头方向
    popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //  弹出
    [self presentViewController:popVC animated:YES completion:^{
        [self hideLoading];
    }];

}

-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{

    return YES;
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
    
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    NSLog(@"dismissed");
    
}

-(void)delegateMethod:(CoustomerList *)coustomer{
    
    NSLog(@"get user info == %@",coustomer.name);
    self.userInfo = coustomer;
    self.counselorId = coustomer.id;
    [UIView performWithoutAnimation:^{
        [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
 
    
}

/****************************************************/
#pragma mark - 判断是横屏还是竖屏
/****************************************************/

- (void)doRotateAction:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"----竖屏----");
     
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"----横屏---");
   
    }
    [self.tableView reloadData];
}

@end
