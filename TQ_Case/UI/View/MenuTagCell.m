//
//  MenuTagCell.m
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "MenuTagCell.h"
#import "TagCell.h"

static NSString * const cellId = @"TagCell";

@implementation MenuTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    self.collectionView.backgroundColor = [UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)configCell0HeightWithInfo:(nullable id)info{
    return 110.f;
}

+ (MenuTagCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"MenuTagCell";
    MenuTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuTagCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


/**********************************************************************/
#pragma mark -UICollectionViewDataSource
/**********************************************************************/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
 
}

/****************************************************/
#pragma mark --UICollectionViewDelegateFlowLayout
/****************************************************/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(88, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSLog(@"cell ----- row == %ld",indexPath.item);

}


@end
