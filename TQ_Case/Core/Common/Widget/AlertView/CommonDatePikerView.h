//
//  CommonDatePikerView.h
//  JinZhuang
//
//  Created by sky on 2019/3/13.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import "BaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonDatePikerView : BaseAlertView

@property (weak, nonatomic) IBOutlet UIDatePicker *pikerView;


+ (instancetype)initWithPikerInfo:(nullable NSDate *)date
                          confirm:(void(^)(NSDate *date))confirmBlock
                           cancle:(void(^)(void))cancleBlock;

@end

NS_ASSUME_NONNULL_END
