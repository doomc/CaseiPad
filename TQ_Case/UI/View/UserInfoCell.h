//
//  UserInfoCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;
//顾问名称
@property (weak, nonatomic) IBOutlet UIButton *counselorNameButton;
@property (weak, nonatomic) IBOutlet UIButton *counselorAvatar;


+ (CGFloat)configCell0HeightWithInfo:(nullable id)info;
+ (UserInfoCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
