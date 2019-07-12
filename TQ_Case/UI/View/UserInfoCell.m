//
//  UserInfoCell.m
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell
{
    NSString * _name;
    NSString * _phone;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];

    self.counselorAvatars.clipsToBounds = YES;
    self.counselorAvatars.layer.cornerRadius = 21;
    self.counselorAvatars.layer.borderWidth = 1;
    self.counselorAvatars.layer.borderColor = [UIColor colorWithRed:10/255.0 green:109/255.0 blue:254/255.0 alpha:1].CGColor;

    [self.userPhoneTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.userNameTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];

    
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


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.userNameTextField == textField) {
        _name = textField.text;
    }
    if (self.userPhoneTextField == textField) {
        _phone = textField.text;
    }
    
    if (self.textFieldBlock) {
        self.textFieldBlock(_name, _phone);
    }
}


@end

