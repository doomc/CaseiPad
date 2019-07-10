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
@property (weak, nonatomic) IBOutlet UITextField *tf_text;

@end

@implementation ScanVC
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)send:(id)sender {

    [self sendWithRoutingKey:@"是的阿萨德阿帅阿帅"];
    
    sleep(5);
    [self receiveWithRoutingKeys:@[@"#"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getCodePost];
    
}


/****************************************************/
#pragma mark -RabbitMQ
/****************************************************/

//接受方法
- (void)receiveWithRoutingKeys:(NSArray *)keys
{
//    当如下指定*为通配符的时候，只有类似fruit.apple,fruit.banana,animals.dog,animals.cat这样的路由键上的消息才会被转发
//    [self receiveWithRoutingKeys:@[@"fruit.*",@"animals.*"]];
//
//    当指定#为通配符的时候，所有的消息都会被收到，比如:test.hello,fruit.apple,animals.dog路由键上的消息都会被转发
//    [self receiveWithRoutingKeys:@[@"#"]];
//
//    当使用如下通配符的时候，只有类似hello.dog,animals.dog,test.dog这样的路由键的消息才会被转发
//    [self receiveWithRoutingKeys:@[@"*.dog",@"*.apple"]];
//
    NSString *url5 = @"amqp://face:face@mqtt.tq-service.com:5672/face";
    RMQConnection * connection = [[RMQConnection alloc] initWithUri:url5 delegate:[RMQConnectionDelegateLogger new]];
    [connection start];
    id<RMQChannel>channel = [connection createChannel];
    RMQExchange *x = [channel topic:@"face" options:RMQQueueDeclareExclusive | RMQQueueDeclareAutoDelete];
    RMQQueue *q = [channel queue:@"" options: RMQQueueDeclareExclusive | RMQQueueDeclareAutoDelete];
    [q bind:x];
    [q subscribe:RMQBasicConsumeNoOptions handler:^(RMQMessage * _Nonnull message) {
        NSLog(@"Received %@", [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
    }];

}

//发送方法
- (void)sendWithRoutingKey:(NSString *)routingKey
{
    NSString *url5 = @"amqp://face:face@mqtt.tq-service.com:5672/face";
    RMQConnection * connection = [[RMQConnection alloc] initWithUri:url5 delegate:[RMQConnectionDelegateLogger new]];
    [connection start];
    id<RMQChannel>channel = [connection createChannel];
    RMQExchange * exchange = [channel topic:@"face" options:RMQQueueDeclareExclusive | RMQQueueDeclareAutoDelete];
    [exchange publish:[routingKey dataUsingEncoding:NSUTF8StringEncoding] routingKey:routingKey];
    [connection close];
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
