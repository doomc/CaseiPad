//
//  ShareManager.m
//  TQ_Case
//
//  Created by apple on 2019/8/27.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "ShareManager.h"
#import "RMQClient.h"

@interface ShareManager ()<NSCopying,NSMutableCopying>

@property (nonatomic, strong) RMQConnection *conn;
@property (nonatomic, strong) RMQQueue *q;

@end

static ShareManager *manager = nil;
@implementation ShareManager

+ (instancetype)instanceManager{
    return [[self alloc] init];
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super init];
    });
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return manager;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return manager;
}


/****************************************************/
#pragma mark -RabbitMQ
/****************************************************/
-(void)creatMQ{
    //固定格式
    NSString *url5 = @"amqp://face:face@mqtt.tq-service.com:5672/face";

    NSString* topic = [NSString stringWithFormat:@"iPad/%@",[APPDELEGATE userManager].projectId];
    NSLog(@"topic = %@",topic);

    /** 创建连接 */
    self.conn = [[RMQConnection alloc] initWithUri:url5 delegate:[RMQConnectionDelegateLogger new]];
    [_conn start];
    /** 创建信道 */
    id<RMQChannel> ch = [_conn createChannel];
    /** 创建交换器 */
    RMQExchange *x = [ch topic:topic options:RMQExchangeDeclareNoOptions];
    //绑定queue
    self.q = [ch queue:topic options:RMQQueueDeclareNoOptions];
    /** 绑定交换器 */
    [_q bind:x];
    /** 订阅消息 */
    __weak typeof(self)weakSelf = self;
    [_q subscribe:^(RMQMessage * _Nonnull message) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        NSString * jsonData= [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
        strongSelf.scanModel = [ScanModel yy_modelWithJSON:jsonData];
        
        NSLog(@"ShareManager - Received = %@",jsonData);
        NSLog(@"ShareManager - method = %@ ",strongSelf.scanModel.method);
        
        //签到中
        if (weakSelf.scanModel.method == nil) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSigningStatusNotification object:nil];
        }
        //已签到
        if ([weakSelf.scanModel.method isEqualToString:@"ipad_user_info"]) {
            //已经获取到用户信息 此处需要跳转到资料录入页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSignedsStatusNotification object:nil];
        }
        //扫描成功 未点击签到
        if ([weakSelf.scanModel.method isEqualToString:@"qr_consume"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationScanSuccessNotification object:nil];
            
        }
        //通知访客
        if ([weakSelf.scanModel.method isEqualToString:@"ipad_model"]) {
            //已经获取到用户信息 此处需要跳转到资料录入页面
            [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationVisitorComeInNotification object:nil];
            
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

//接受消息
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

-(void)closeMQ{
    
    [self.conn close];
}



-(ScanModel *)scanModel{
    if (!_scanModel) {
        _scanModel = [[ScanModel alloc]init];
    }
    return _scanModel;
}


@end
