//
//  MenuTagCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExchangeJsonBlock)(NSString * json);

@interface MenuTagCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong , nonatomic) NSArray *dataArray;
//判断是多选还是单选 isMark = @“1” 多选  isMark = @“0”单选
@property (copy , nonatomic) NSString * isMark;
@property (copy , nonatomic) ExchangeJsonBlock exchangeBlock;

+ (CGFloat)configCell0HeightWithInfo:(nullable id)info;
+ (MenuTagCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
