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


@interface RecordInfoVC ()<UITableViewDelegate,UITableViewDataSource>

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

@end

@implementation RecordInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles0 = @[@"自然到访",@"老带新",@"渠道",@"媒体",@"电梯广告",@"商场",@"是"];
    self.titles1 = @[@"业主",@"同行",@"房闹",@"投诉",@"其他"];
    self.titles2 = @[@"小高层",@"别墅",@"洋房",@"其他"];
    self.tableView.backgroundColor = [UIColor clearColor];
  
    //获取客户列表
    [GHNetworkManager user_getCoustomerListWithprojectId:[APPDELEGATE userManager].projectId success:^(NSArray *customerList, NSString *msg) {
        
    } failure:^(NSError *error) {
        
    }];

    
    //获取关联职业顾问
    [GHNetworkManager user_getCounselorListWithprojectId:[APPDELEGATE userManager].projectId success:^(NSArray *customerList, NSString *msg) {
        if (customerList.count > 0) {
            CoustomerList * model = customerList[0];
    
            [self.commitButton yy_setImageWithURL:[NSURL URLWithString:model.faceUrl] forState:UIControlStateNormal options:YYWebImageOptionUseNSURLCache];
        }
    } failure:^(NSError *error) {

    }];

    //获取码表
//    [GHNetworkManager user_getCodeListWithTag:@"" success:^(id info, NSString *msg) {
//
//    } failure:^(NSError *error) {
//
//    }];
    

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
            return cell;
        }; break;
        case 1:{//用户信息
            UserInfoCell * cell = [UserInfoCell configCell0:tableView indexPath:indexPath];
            return cell;
        }; break;
        case 2:{//来源渠道标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.dataArray = self.titles0;
            return cell;
        }; break;
        case 3:{//用户身份标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.titleLabel.text = @"用户身份";
            cell.detailLabel.text = @"（请选择用户身份，可多选！）";
            cell.dataArray = self.titles1;
            return cell;
        }; break;
        case 4:{// 物业形态标签
            MenuTagCell * cell = [MenuTagCell configCell0:tableView indexPath:indexPath];
            cell.titleLabel.text = @"物业形态";
            cell.detailLabel.text = @"（请选择物业形态，单选！）";
            cell.dataArray = self.titles2;
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
            return [HeaderCollectionCell configCell0HeightWithInfo:nil];
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
 
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark  - 提交信息

- (IBAction)commitAction:(id)sender {

    if (![self.ownerName isNotBlank]) {
        [OMGToast showWithText:@"姓名不能为空"];
    }
    if (![self.ownerPhone isNotBlank]) {
        [OMGToast showWithText:@"手机号不能为空"];
    }
    //获取客户列表
    [GHNetworkManager user_saveVisitorRecordWithUserId:[APPDELEGATE userManager].userId
                                              ownerName:self.ownerName
                                                  phone:self.ownerPhone
                                              projectId:[APPDELEGATE userManager].projectId
                                                 soruce:@""
                                             employeeId:@""
                                                 openId:@""
                                                 gender:@""
                                               ageGroup:@""
                                                  glass:@""
                                                faceUrl:@""
                                               userType:@""
                                              houseType:@""
                                             happenTime:@""
                                                 remark:@""
                                                success:^(id info, NSString *msg) {
                                                    
                                                } failure:^(NSError *error) {
                                                    
                                                }];

}






@end
