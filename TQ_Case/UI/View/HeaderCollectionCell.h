//
//  HeaderCollectionCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderCollectionCell : UITableViewCell

@property (strong , nonatomic) NSArray *dataArray;
@property (strong , nonatomic) NSMutableArray *selectArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView0;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView1;


+ (CGFloat)configCell0HeightWithInfo:(nullable id)info;
+ (HeaderCollectionCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
