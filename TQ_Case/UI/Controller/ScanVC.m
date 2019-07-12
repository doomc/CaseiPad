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
@property (nonatomic,strong) RMQConnection *conn;

@end

@implementation ScanVC
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getCodePost];
    
    [self creatMQ];
}


/****************************************************/
#pragma mark -RabbitMQ
/****************************************************/
-(void)creatMQ{
    
    NSString *url5 = @"amqp://face:face@mqtt.tq-service.com:5672/face";
    NSString* topic = [NSString stringWithFormat:@"iPad/%@",[APPDELEGATE userManager].projectId];
    /** 创建连接 */
    self.conn = [[RMQConnection alloc] initWithUri:url5 delegate:[RMQConnectionDelegateLogger new]];
    [self.conn start];
    /** 创建信道 */
    id<RMQChannel> ch = [self.conn createChannel];
    /** 创建交换器 */
    RMQExchange *x = [ch topic:topic options:RMQExchangeDeclareNoOptions];
    RMQQueue *q = [ch queue:topic options:RMQQueueDeclareNoOptions];
    /** 绑定交换器 */
    [q bind:x];
    /** 订阅消息 */
    [q subscribe:^(RMQMessage * _Nonnull message) {
        NSLog(@"Received %@", [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
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
@end
