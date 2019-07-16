//
//  ScanVC.m
//  TQ_Case
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "ScanVC.h"
#import "RecordInfoVC.h"
#import "RMQClient.h"

@interface ScanVC ()

@property (copy, nonatomic) NSString *scanImageUrl;
@property (weak, nonatomic) IBOutlet UIImageView *loadingScanImage;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@property (nonatomic,strong) ScanModel *scanModel;
@end

@implementation ScanVC
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatMQ];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.loadingLabel setHidden:YES];
    [self getCodePost];
}


/****************************************************/
#pragma mark -RabbitMQ
/****************************************************/
-(void)creatMQ{
    //固定格式
    NSString *url5 = @"amqp://face:face@mqtt.tq-service.com:5672/face";
    
    NSString* topic = [NSString stringWithFormat:@"iPad/%@",[APPDELEGATE userManager].projectId];
    /** 创建连接 */
    RMQConnection * conn = [[RMQConnection alloc] initWithUri:url5 delegate:[RMQConnectionDelegateLogger new]];
    [conn start];
    /** 创建信道 */
    id<RMQChannel> ch = [conn createChannel];
    /** 创建交换器 */
    RMQExchange *x = [ch topic:topic options:RMQExchangeDeclareNoOptions];
    //绑定queue
    RMQQueue *q = [ch queue:topic options:RMQQueueDeclareNoOptions];
    /** 绑定交换器 */
    [q bind:x];
    /** 订阅消息 */

    __weak typeof(self)weakSelf = self;
    [q subscribe:^(RMQMessage * _Nonnull message) {
        __strong typeof(self)strongSelf = weakSelf;
        NSString * jsonData= [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
        NSLog(@"Received = %@",jsonData);
        strongSelf.scanModel = [ScanModel yy_modelWithJSON:jsonData];
        NSLog(@" scanModel =%@ ",strongSelf.scanModel);

        if (strongSelf.scanModel.method == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self)strong = self;
                //签到中
                [strong.loadingLabel setHidden:NO];
            });
        }
        if ([weakSelf.scanModel.method isEqualToString:@"ipad_user_info"]) {//已经获取到用户信息 此处需要跳转到资料录入页面
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self)strong = self;

                RecordInfoVC * userInfoVC = [RecordInfoVC new];
                userInfoVC.scanUserInfo = strong.scanModel.param;
                userInfoVC.backName = @"RecordInfoVC";
                [strong.navigationController pushViewController:userInfoVC animated:NO];
            });
        }
    }];
}

//发送方法 -- 只发送到同一个主题和queue
- (void)sendMQ
{
    NSString *url = @"amqp://face:face@mqtt.tq-service.com:5672/face";//:5672/face
    RMQConnection * connection = [[RMQConnection alloc] initWithUri:url delegate:[RMQConnectionDelegateLogger new]];
    [connection start];
    id<RMQChannel>channel = [connection createChannel];
    RMQExchange * exchange = [channel topic:@"service/002" options:RMQExchangeDeclarePassive];
    RMQQueue *queue = [channel queue:@"service/002"];
    [queue bind:exchange];
    [exchange publish:[@"输入发送的内容" dataUsingEncoding:NSUTF8StringEncoding] routingKey:@""];
    [connection close];
  
}

- (void)receiveMQ
{
    NSString* topic = [NSString stringWithFormat:@"iPad/%@",[APPDELEGATE userManager].projectId];
    NSString *url = @"amqp://face:face@mqtt.tq-service.com:5672/face";//:5672/face
    RMQConnection * conn = [[RMQConnection alloc] initWithUri:url delegate:[RMQConnectionDelegateLogger new]];
    [conn start];
    id<RMQChannel>channel = [conn createChannel];
    RMQExchange * exchange = [channel topic:topic options:RMQExchangeDeclarePassive];
    RMQQueue * queue = [channel queue:topic];
    [queue bind:exchange];
    [queue subscribe:^(RMQMessage * _Nonnull message) {
        NSLog(@"接受信息 ==message:%@",[[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
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


//获取二维码
-(void)getCodePost{
    
    [self showLoadingWithMessage:@"Load..."];
    [GHNetworkManager user_getScanCodeWithUserId:[APPDELEGATE userManager].userId projectId:[APPDELEGATE userManager].projectId success:^(id info, NSString *msg) {
        [self hideLoading];
        
        self.scanImageUrl = [NSString stringWithFormat:@"%@", info[@"data"]];
        [self.loadingScanImage yy_setImageWithURL:[NSURL URLWithString:self.scanImageUrl] placeholder:[UIImage imageNamed:@"sacnCode"]];
        
    } failure:^(NSError *error) {
        [self hideLoading];
    }];
}


-(void)getUserInfoMessage{
    RecordInfoVC * controller = [RecordInfoVC new];
    [self.navigationController pushViewController:controller animated:NO];
}


-(ScanModel *)scanModel{
    if (!_scanModel) {
        _scanModel = [[ScanModel alloc]init];
    }
    return _scanModel;
}

@end
