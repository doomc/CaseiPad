//
//  Created by sky on 2017/11/4.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "NSObject+ServerURL.h"
#import "NSUserDefaults+UserInfo.h"


@implementation NSObject (ServerURL)


//平台类型（0正式平台，1测试平台)
- (NSString *)getSERVERURL_CASE{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *serverUrl = nil;
    NSArray *serverUrls = [self getSERVERURL_CaseArray];
    if([userInfo getPlanform] != nil && ISTEST == 1){
        NSInteger planform = [[userInfo getPlanform] integerValue];
        serverUrl = [serverUrls objectAtIndex:planform];
    }else{
        serverUrl = [serverUrls objectAtIndex:PLANTFORM];
    }
    return serverUrl;
}


- (NSArray *)getSERVERURL_CaseArray{ //tqdata/template/
    NSArray *serverUrls = [NSArray arrayWithObjects:@"https://digital.tq-service.com/tqdata/api/",@"https://dev-mml.tq-service.com/tqdata/api/",@"http://10.15.208.134:9002/tqdata/api/",@"http://192.168.10.184:9000/",nil];
    return serverUrls;
}








@end
