//
//  CommonOneSelectPikerView.h
//  QianBaoReDianB
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 qianbao. All rights reserved.
//

#import "BaseAlertView.h"
@class CommonPikerInfo;

@interface CommonOneSelectPikerView : BaseAlertView
@property (weak, nonatomic) IBOutlet UIPickerView *pikerView;


+ (instancetype)initWithCommonPikerInfo:(CommonPikerInfo *)info
                              dataArray:(NSArray<CommonPikerInfo *> *)dataArray
                                confirm:(void(^)(CommonPikerInfo *info))confirmBlock
                                 cancle:(void(^)(void))cancleBlock;


@end

@interface CommonPikerInfo : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *number;


@end
