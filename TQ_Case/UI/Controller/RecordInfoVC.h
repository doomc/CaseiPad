//
//  RecordInfoVC.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordInfoVC : BSViewController

//扫码后获取到的用户信息
@property (nonatomic,strong) ScanUserInfo *scanUserInfo;
@property (nonatomic,copy) NSString * backName;


@end

NS_ASSUME_NONNULL_END
