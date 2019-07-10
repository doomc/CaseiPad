//
//  CommonDatePikerView.m
//  JinZhuang
//
//  Created by sky on 2019/3/13.
//  Copyright © 2019年 EDO. All rights reserved.
//

#import "CommonDatePikerView.h"

@interface CommonDatePikerView ()

@property (copy, nonatomic) void(^confirmBlock)(NSDate *date);
@property (copy, nonatomic) void(^cancelBlock)(void);

@end

@implementation CommonDatePikerView


+ (instancetype)initWithPikerInfo:(nullable NSDate *)date
                          confirm:(void(^)(NSDate *date))confirmBlock
                           cancle:(void(^)(void))cancleBlock{
    CommonDatePikerView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CommonDatePikerView" owner:nil options:nil] firstObject];
    [alert setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    [alert setBackgroundColor:[UIColor clearColor]];
    if (date == nil) {
        date = [NSDate date];
    }
    [alert.pikerView setDate:date];
    [alert setConfirmBlock:confirmBlock];
    [alert setCancelBlock:cancleBlock];
    return alert;
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissWithAnimation:kAlertAnimationBottom];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)confirmButtonAction:(id)sender {
    [self dismissWithAnimation:kAlertAnimationBottom];
    if (self.confirmBlock) {
        self.confirmBlock(self.pikerView.date);
    }
}


@end
