//
//  UserHeaderCell2.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderCell2 : UICollectionViewCell
///展示的图片
@property (weak, nonatomic) IBOutlet UIImageView *showAvatarImage;
//虚线
@property (weak, nonatomic) IBOutlet UIImageView *firstImageBoard;
//删除图片
@property (weak, nonatomic) IBOutlet UIImageView *deleteTypeImage;
///需要添加删除
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
///客户类型
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

+ (CGSize)configCell0HeightWithInfo:(nullable id)info;


@end

NS_ASSUME_NONNULL_END
