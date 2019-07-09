
//
//  HeaderCollectionCell.m
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//


#import "HeaderCollectionCell.h"
#import "UserHeaderCell.h"
#import "UserHeaderCell2.h"

static NSString * const  collectionCell0 = @"UserHeaderCell0";
static NSString * const  collectionCell1 = @"UserHeaderCell1";

@interface HeaderCollectionCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation HeaderCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 
    self.collectionView0.delegate = self;
    self.collectionView0.dataSource = self;
    [self.collectionView0 registerNib:[UINib nibWithNibName:@"UserHeaderCell" bundle:nil] forCellWithReuseIdentifier:collectionCell0];

    
    self.collectionView1.delegate = self;
    self.collectionView1.dataSource = self;
    [self.collectionView1 registerNib:[UINib nibWithNibName:@"UserHeaderCell2" bundle:nil] forCellWithReuseIdentifier:collectionCell1];

}

#pragma mark - config tableview
+ (CGFloat)configCell0HeightWithInfo:(nullable id)info{
    return 564;
}

+ (HeaderCollectionCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"HeaderCollectionCell";
    HeaderCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCollectionCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**********************************************************************/
#pragma mark -UICollectionViewDataSource
/**********************************************************************/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.collectionView0 == collectionView) {
        return 30;
    }else{
        return 20;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.collectionView0 == collectionView) {
        UserHeaderCell* headCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell0 forIndexPath:indexPath];
        return headCell;
    }else{
        UserHeaderCell2* headCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell1 forIndexPath:indexPath];
        return headCell;
    }
}

/****************************************************/
#pragma mark --UICollectionViewDelegateFlowLayout
/****************************************************/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.collectionView0 == collectionView) {
        return  [UserHeaderCell configCell0HeightWithInfo:nil];
    }else{
        return  [UserHeaderCell2 configCell0HeightWithInfo:nil];
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.collectionView0 == collectionView) {
        NSLog(@"cell0 ----- row == %ld",indexPath.item);
    }else{
        NSLog(@"cell1 ----- row == %ld",indexPath.item);
    }
}







@end
