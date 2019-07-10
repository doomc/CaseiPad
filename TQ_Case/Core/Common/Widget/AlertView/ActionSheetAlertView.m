//
//  ActionSheetAlertView.m
//  RJ-Golf
//
//  Created by sky on 2018/5/24.
//  Copyright © 2018年 XFC. All rights reserved.
//

#import "ActionSheetAlertView.h"

@interface ActionSheetAlertView()

@property (weak, nonatomic) IBOutlet UIButton *title1Button;
@property (weak, nonatomic) IBOutlet UIButton *title0Button;
@property (copy, nonatomic) void(^confirmBlock)(ActionSheetAlertView *shareView,NSInteger index);
@property (copy, nonatomic) void(^cancelBlock)(ActionSheetAlertView *shareView);

@end

@implementation ActionSheetAlertView

+ (id)initActionSheetAlertWithTitleArray:(NSArray *)titleArray
                            confirmBlock:(void (^)(ActionSheetAlertView *alertView,NSInteger index))confirmBlock
                             cancleBlock:(void (^)(ActionSheetAlertView *alertView))cancleBlock{
    
    ActionSheetAlertView *view = [[[NSBundle mainBundle] loadNibNamed:@"ActionSheetAlertView" owner:nil options:nil] firstObject];
    [view setBackgroundColor:[UIColor clearColor]];
    [view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    [view setConfirmBlock:confirmBlock];
    [view setCancelBlock:cancleBlock];
    
    if (titleArray.count >= 1) {
        [view.title1Button setTag:0];
        [view.title1Button setTitle:[titleArray objectAtIndex:0] forState:UIControlStateNormal];
    }
    if (titleArray.count >= 2) {
        [view.title0Button setTag:1];
        [view.title0Button setTitle:[titleArray objectAtIndex:1] forState:UIControlStateNormal];
    }
    return view;
}


- (IBAction)cancelButtonAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (IBAction)confirmButtonAction:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self, sender.tag);
    }
}


@end
