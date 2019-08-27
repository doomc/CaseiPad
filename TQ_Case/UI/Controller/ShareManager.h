//
//  ShareManager.h
//  TQ_Case
//
//  Created by apple on 2019/8/27.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject

@property (nonatomic, strong) ScanModel *scanModel;

+ (instancetype)instanceManager;

//创建MQ
-(void)creatMQ;

//关闭MQ
-(void)closeMQ;




@end

NS_ASSUME_NONNULL_END
