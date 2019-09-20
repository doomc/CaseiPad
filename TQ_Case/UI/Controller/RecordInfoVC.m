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
#import "NoticePopView.h"
#import "AFNetworkReachabilityManager.h"


@interface RecordInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,PopViewControllerDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet WQRefreshTableView *tableView;
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

@property (strong, nonatomic) NSArray * avatarsList;//抓拍头像
@property (strong, nonatomic) NSArray * counselorList;//置业顾问
@property (strong, nonatomic) NSMutableArray * choosed;//已选客户
@property (strong, nonatomic) EmployeeList * employeeInfo;

@property (assign , nonatomic) CGFloat kcollectionView0Height;

//添加抖动手势
@property (strong, nonatomic) UILongPressGestureRecognizer * shakeGes;
//添加移动手势
@property (strong, nonatomic) UILongPressGestureRecognizer * longPressMoveGes;
//是否抖动
@property (assign, nonatomic) BOOL isBegin;

@property (strong , nonatomic) AFNetworkReachabilityManager *manger;


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
    
    [self.tableView setAllowShowBlank:NO];
    
    WS(weakSelf);
    //监测方法
    self.manger = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [self.manger startMonitoring];
    //2.监听改变
    [self.manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [weakSelf.tableView refreshData];
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [weakSelf.tableView refreshData];

                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                [weakSelf.tableView refreshData];
                break;
            default:
                break;
        }
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

    if (self.choosed.count == 0) {
        [OMGToast showWithText:@"请选择客户"];
        return;
    }
    if (![self.ownerName isNotBlank]) {
        [OMGToast showWithText:@"姓名不能为空"];
        return;
    }
    if (![self.ownerPhone isNotBlank] && ![self.ownerPhone isMobilphone]) {
        [OMGToast showWithText:@"手机格式不对"];
        return;
    }
    if (![self.counselorId isNotBlank]) {
        [OMGToast showWithText:@"请选择您的置业顾问"];
        return;
    }

    [self showLoadingWithMessage:@"正在录入信息..."];
    //保存访客列表

//    [GHNetworkManager user_saveVisitorRecordWithUserId:[APPDELEGATE userManager].userId
//                                              ownerName:self.ownerName
//                                                  phone:self.ownerPhone
//                                             projectId:[APPDELEGATE userManager].projectId
//                                                soruce:self.sourceType
//                                            employeeId:self.counselorId
//                                                openId:self.scanUserInfo.openId?self.scanUserInfo.openId:@""
//                                                gender:@""
//                                              ageGroup:@""
//                                                 glass:@""
//                                                faceUrl:self.customerfaceUrl
//                                               userType:self.userType
//                                              houseType:self.wyType
//                                             happenTime:@""//抓拍时间
//                                                remark:self.remark
//                                                success:^(id info, NSString *msg) {
//                                                    [OMGToast showWithText:@"信息录入成功！"];
//                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                                        [self.navigationController popViewControllerAnimated:YES];
//                                                    });
//                                                    [self hideLoading];
//                                                } failure:^(NSError *error) {
//                                                    [self hideLoading];
//                                                    [OMGToast showWithText:@"信息录入失败！"];
//                                                }];
    
    CoustomerList * customer = self.choosed.firstObject;
    WS(weakSelf);
    NSDictionary * customer1 = @{
                                 
                                 @"customerDataSource":@"3",//表示iPad来源
                                 @"ageRange":customer.ageGroup,
                                 @"birthday":@"",
                                 @"sex":customer.gender,
                                 @"intentionLevel":@"",//意向等级
                                 @"employeeId":self.counselorId,
                                 @"faceId":customer.visitorId,//改成访客 visitId
                                 @"customerName":self.ownerName,
                                 @"headPicture":customer.faceUrl,
                                 @"knowSource":@"",//认知途径
                                 @"customerType":self.userType?self.userType:@"",
                                 @"phone":self.ownerPhone,
                                 @"projectId":customer.projectId,
                                 @"sourcePath":self.sourceType?self.sourceType:@"",//来源途径
                                 @"certificateNumber":@"",
                                 @"certificateType":@"",
                                 };
    
    NSMutableArray * customer2 = [NSMutableArray array];
    for (CoustomerList * list in self.choosed) {
        if (!list.isFirstCustomer) {
            NSDictionary * dict = @{
                                    @"headPicture":list.faceUrl?list.faceUrl:@"",
                                    @"ageRange":list.ageGroup?list.ageGroup:@"",
                                    @"visitTime":list.happenTime,
                                    @"certificateNumber":@"",
                                    @"phone":list.phone,
                                    @"sex":list.gender,
                                    @"contactAddress":@"",
                                    @"faceId":list.visitorId,
                                    @"customerName":list.ownerName?list.ownerName:@"",
                                    @"relation":@"",
                                    @"certificateType":@"",
        
                                    };
            
            [customer2 addObject:dict];
        }
    }
    
    [GHNetworkManager user_addTqCustomerPo:customer1 tqRelationCustomersPos:customer2 employeeId:self.counselorId projectId:[APPDELEGATE userManager].projectId success:^(id info, NSString *msg) {
        if (msg == nil) {
            [OMGToast showWithText:@"信息录入成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [OMGToast showWithText:msg];
        }
        [weakSelf hideLoading];

    } failure:^(ErrorsModel *error, BOOL isSuccess) {
        [weakSelf hideLoading];
        if (isSuccess) {
            [OMGToast showWithText:@"信息录入成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [OMGToast showWithText:error.msg];
        }
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

-(void)delegateMethod:(EmployeeList *)coustomer{
    
    NSLog(@"get user info == %@",coustomer.name);
    self.employeeInfo = coustomer;
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


/****************************************************/
#pragma mark - UITableViewDataSource
/****************************************************/

- (NSInteger)numberOfSectionsInTableView:(WQRefreshTableView *)tableView{

    return 6;
}

- (NSInteger)tableView:(WQRefreshTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(WQRefreshTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (UITableViewCell *)tableView:(WQRefreshTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
                    [cell.loadingMoreButton  setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
                    
                    CGFloat height = cell.collectionView0.collectionViewLayout.collectionViewContentSize.height;
                    
                    cell.collectionView0ConstrainsHeight.constant = self.kcollectionView0Height =   height > 226 ? height :226;
                    NSLog(@"sssssssssssss %.f",height);
                }else{
                    [cell.loadingMoreButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
                    [cell.loadingMoreButton  setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
                    cell.collectionView0ConstrainsHeight.constant = self.kcollectionView0Height = 226;
                }
                
            }];
            
            if (self.choosed) {
                cell.selectArray = self.choosed;
                [cell reloadCollectionViewData1];
                [cell reloadCollectionViewData0];
                
            }
            cell.selectAvatarBlock = ^(NSMutableArray * _Nonnull selectArray) {
                //已选数组  标记第一个为客户
                weakSelf.choosed = selectArray;
                [weakSelf.choosed enumerateObjectsUsingBlock:^(CoustomerList*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == 0) {
                        obj.isFirstCustomer = YES;
                    }else{
                        obj.isFirstCustomer = NO;
                    }
                }];
                
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
                if (phone) {
                    weakSelf.ownerPhone = phone;
              
                }
                if (name) {
                    weakSelf.ownerName = name;
                }
                [weakSelf check];
                
            };
            [cell.counselorNameButton setAction:^{//选择顾问
                [weakSelf showPopView:cell.counselorNameButton];
            }];
            if (self.employeeInfo) {
                //设置头像
                [cell.counselorAvatars yy_setImageWithURL:[NSURL URLWithString:self.employeeInfo.faceUrl] placeholder:nil];
                //顾问姓名
                [cell.counselorNameButton setTitle:self.employeeInfo.name forState:UIControlStateNormal];
            }
            
            return cell;
        }; break;
        case 2:{//来源渠道标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.isMark =@"0";
            cell.dataArray = self.titles0;
            cell.detailLabel.text = @"（请选择来源渠道，单选！）";
            cell.exchangeBlock = ^(NSString * _Nonnull json) {
                NSLog(@"渠道标签 === %@",json);
                weakSelf.sourceType = json;
            };
            return cell;
        }; break;
        case 3:{//用户身份标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.isMark =@"0";
            cell.exchangeBlock = ^(NSString * _Nonnull json) {
                NSLog(@"身份标签 === %@",json);
                weakSelf.userType = json;
            };
            cell.titleLabel.text = @"用户身份";
            cell.detailLabel.text = @"（请选择用户身份，单选！）";
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
                NSLog(@"物业形态 === %@",json);
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

-(void)check{

    NSLog(@"name = %@,phone = %@",self.ownerName,self.ownerPhone);
    
    if (self.ownerName.length == 0) {
        [OMGToast showWithText:@"请输入姓名"];
        [self.commitButton setImage:[UIImage imageNamed:@"user_commit_disable"] forState:UIControlStateNormal];
        [self.commitButton setEnabled:NO];
        return;
    }
    if (self.ownerPhone.length == 11) {
        if (![self.ownerPhone isMobilphone]) {
            [OMGToast showWithText:@"手机格式错误"];
            return;
        }
    }else{
        [self.commitButton setImage:[UIImage imageNamed:@"user_commit_disable"] forState:UIControlStateNormal];
        [self.commitButton setEnabled:NO];
        return;
    }

    [self.commitButton setImage:[UIImage imageNamed:@"user_commit_enable"] forState:UIControlStateNormal];
    [self.commitButton setEnabled:YES];
 
 
}
/**********************************************************************/
#pragma mark - WQRefreshTableViewDelegate
/**********************************************************************/


- (void)tableView:(WQRefreshTableView *)tableView
        pageIndex:(NSUInteger)pageIndex
          success:(void (^)(NSArray * _Nullable list, BOOL hasNext))success
          failure:(void (^)(NSError *error))failure{
    
    if (self.manger.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [OMGToast showWithText:@"当前网络异常,请检查网络"];
        success(nil,NO);
        return;
    }
    [self showLoadingWithMessage:@"数据载入中..."];

    WS(weakSelf);
    //获取客户列表
    [GHNetworkManager user_catchPicWithProjectId:[APPDELEGATE userManager].projectId timegroup:@"day" success:^(NSArray *list, NSString *msg) {
        weakSelf.avatarsList  = list;
        [weakSelf.tableView reloadData];
        success(list,NO);
    } failure:^(NSError *error) {
        [weakSelf hideLoading];
        [OMGToast showWithText:error.localizedDescription];
    }];

    
    //获取关联置业顾问
    [GHNetworkManager user_getCounselorListWithprojectId:[APPDELEGATE userManager].projectId success:^(NSArray *customerList, NSString *msg) {
        if (customerList.count > 0) {
            weakSelf.counselorList  = customerList;
        }
        [weakSelf hideLoading];
    } failure:^(NSError *error) {
        [weakSelf hideLoading];
    }];
    
    //获取码表 来源渠道
    [GHNetworkManager user_getCodeListWithTag:@"CHANNEL" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles0 = tagList;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    
    //用户身份
    [GHNetworkManager user_getCodeListWithTag:@"USERTYPE" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles1 = tagList;
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
    }];
    
    //物业形态
    [GHNetworkManager user_getCodeListWithTag:@"PROPERTYTYPE" success:^(NSArray *tagList, NSString *msg) {
        weakSelf.titles2 = tagList;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}




@end
