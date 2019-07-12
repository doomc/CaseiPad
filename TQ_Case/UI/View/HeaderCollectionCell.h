//
//  HeaderCollectionCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectAvatarBlock)(NSMutableArray * selectArray);

@interface HeaderCollectionCell : UITableViewCell

@property (strong , nonatomic) NSArray *dataArray;
@property (strong , nonatomic) NSMutableArray *selectArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView0;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionView0ConstrainsHeight;
//加载更多
@property (weak, nonatomic) IBOutlet UIButton *loadingMoreButton;
 

//未选择用户显示
@property (weak, nonatomic) IBOutlet UIView *noChooseView;
//无数据标签
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@property (copy, nonatomic) SelectAvatarBlock selectAvatarBlock;

+ (CGFloat)configCell0HeightWithInfo:(CGFloat)cell0Height;

+ (HeaderCollectionCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

-(void)reloadCollectionViewData0;
-(void)reloadCollectionViewData1;

@end

NS_ASSUME_NONNULL_END
