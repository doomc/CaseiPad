//
//  UserInfoCell.m
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];

    self.counselorAvatar.clipsToBounds = YES;
    self.counselorAvatar.layer.cornerRadius = 21;
    self.counselorAvatar.layer.borderWidth = 1;
    self.counselorAvatar.layer.borderColor = [UIColor colorWithRed:10/255.0 green:109/255.0 blue:254/255.0 alpha:1].CGColor;

}

+ (CGFloat)configCell0HeightWithInfo:(nullable id)info{
    return 145;
}

+ (UserInfoCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"UserInfoCell";
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
