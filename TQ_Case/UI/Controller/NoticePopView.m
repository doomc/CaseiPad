//
//  NoticePopView.m
//  TQ_Case
//
//  Created by apple on 2019/8/26.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "NoticePopView.h"
@interface NoticePopView ()

@property (weak, nonatomic) IBOutlet UIView *boardView;
//客户
@property (weak, nonatomic) IBOutlet UILabel *noticeNameLabel;
//到访次数
@property (weak, nonatomic) IBOutlet UILabel *noticeCountLabel;
//接待描述
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
//到访图片
@property (weak, nonatomic) IBOutlet UIImageView *noticeHeadImageView;

@property (copy, nonatomic) void(^confirmBlock)(NoticePopView *shareView);
@property (copy, nonatomic) void(^cancelBlock)(NoticePopView *shareView);

@end

@implementation NoticePopView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/****************************************************/
#pragma mark - Method Action
/****************************************************/
//关闭
- (IBAction)closeButtonAction:(id)sender {
    
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

//确认收到
- (IBAction)sureCommitAction:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self);
    }
}


+(id)initAlertShowCustomer:(NSString *)customer
                visitCount:(NSString *)visitCount
                    worker:(NSString *)worker
                 headerUrl:(NSString *)headerUrl
              confirmBlock:(void (^)(NoticePopView *popView))confirmBlock
               cancleBlock:(void (^)(NoticePopView *popView))cancleBlock
{
    NoticePopView * nnoticeView = [[[NSBundle mainBundle] loadNibNamed:@"NoticePopView" owner:nil options:nil] firstObject];
   
    nnoticeView.boardView.layer.cornerRadius = 8;
    [nnoticeView setBackgroundColor:[UIColor clearColor]];
    [nnoticeView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
  
    if (worker.length > 0) {
        [nnoticeView.noticeLabel setAttributedText:[nnoticeView attributedString:worker]];
    }else{
        [nnoticeView.noticeLabel setText:@"请通知职业顾问准备接待"];  
    }
    [nnoticeView.noticeNameLabel setText:customer];
    [nnoticeView.noticeCountLabel setText:visitCount];
    [nnoticeView.noticeHeadImageView yy_setImageWithURL:[NSURL URLWithString:headerUrl] placeholder:nil];
    
    [nnoticeView setCancelBlock:cancleBlock];
    [nnoticeView setConfirmBlock:confirmBlock];
    
    return nnoticeView;
}


-(NSMutableAttributedString *)attributedString:(NSString *)worker{
    
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"请通知 %@ 职业顾问准备接待",worker]];
    
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"E7CF82"] range:NSMakeRange(4, worker.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:15] range:NSMakeRange(4, worker.length)];
    return attr;
}

@end
