//
//  CommonOneSelectPikerView.m
//  QianBaoReDianB
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 qianbao. All rights reserved.
//

#import "CommonOneSelectPikerView.h"
@class CommonPikerInfo;

@interface CommonOneSelectPikerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (copy, nonatomic) void(^confirmBlock)(CommonPikerInfo *info);
@property (copy, nonatomic) void(^cancelBlock)(void);

@property (strong, nonatomic) NSArray *dataArray;

@end


@implementation CommonOneSelectPikerView


+ (instancetype)initWithCommonPikerInfo:(CommonPikerInfo *)info
                              dataArray:(NSArray *)dataArray
                                confirm:(void(^)(CommonPikerInfo *info))confirmBlock
                                 cancle:(void(^)(void))cancleBlock{
    CommonOneSelectPikerView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CommonOneSelectPikerView" owner:nil options:nil] firstObject];
    [alert setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    [alert setBackgroundColor:[UIColor clearColor]];
    NSInteger indexRow = 0;
    if (info != nil && dataArray.count > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID = %@",info.ID];
        NSArray *searchArray = [dataArray filteredArrayUsingPredicate:predicate];
        if (searchArray.count > 0) {
            CommonPikerInfo *currentInfo = [searchArray firstObject];
            indexRow = [dataArray indexOfObject:currentInfo];
        }
    }
    [alert setDataArray:dataArray];
    [alert.pikerView setDelegate:alert];
    [alert.pikerView setDataSource:alert];
    [alert.pikerView reloadAllComponents];
    [alert.pikerView selectRow:indexRow inComponent:0 animated:NO];
    [alert setConfirmBlock:confirmBlock];
    [alert setCancelBlock:cancleBlock];
    return alert;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CommonPikerInfo *info = [self.dataArray objectAtIndex:row];
    return info.content;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
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
        if(self.dataArray.count > 0){
            NSInteger index = [self.pikerView selectedRowInComponent:0];
            if (index >= 0) {
                self.confirmBlock([self.dataArray objectAtIndex:index]);
            }
        }else{
            self.confirmBlock(nil);
        }
        
    }
}

@end

@implementation CommonPikerInfo

@end
