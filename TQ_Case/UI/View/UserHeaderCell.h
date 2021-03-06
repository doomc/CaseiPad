//
//  UserHeaderCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView0;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage0;


+ (CGSize)configCell0HeightWithInfo:(nullable id)info;


@end

NS_ASSUME_NONNULL_END
