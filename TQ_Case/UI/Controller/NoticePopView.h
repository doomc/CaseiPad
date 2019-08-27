//
//  NoticePopView.h
//  TQ_Case
//
//  Created by apple on 2019/8/26.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN


@interface NoticePopView : BaseAlertView
/**
 *  param customer 客户名称
 *  param visitCount 拜访次数
 *  param worker  工作人员
 *  param alpha 背景透明度
 */

+(id)initAlertShowCustomer:(NSString *)customer
                visitCount:(NSString *)visitCount
                    worker:(NSString *)worker
                 headerUrl:(NSString *)headerUrl
              confirmBlock:(void (^)(NoticePopView *popView))confirmBlock
               cancleBlock:(void (^)(NoticePopView *popView))cancleBlock;

@end

NS_ASSUME_NONNULL_END
