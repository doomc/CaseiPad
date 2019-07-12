//
//  CounselorCell.m
//  TQ_Case
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "CounselorCell.h"

@implementation CounselorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 28.f;
    [self.headImage setShadow:CGSizeMake(2, 3) corner:28.f opacity:0.5 color:[UIColor colorWithHexString:@"ACB2BC"]];
}

@end
