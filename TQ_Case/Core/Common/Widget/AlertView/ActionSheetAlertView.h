//
//  ActionSheetAlertView.h
//  RJ-Golf
//
//  Created by sky on 2018/5/24.
//  Copyright © 2018年 XFC. All rights reserved.
//

#import "BaseAlertView.h"

@interface ActionSheetAlertView : BaseAlertView

+ (id)initActionSheetAlertWithTitleArray:(NSArray *)titleArray
                            confirmBlock:(void (^)(ActionSheetAlertView *alertView,NSInteger index))confirmBlock
                             cancleBlock:(void (^)(ActionSheetAlertView *alertView))cancleBlock;

@end
