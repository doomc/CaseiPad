
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

@interface HeaderCollectionCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (strong , nonatomic) NSIndexPath *currentSelectIndex;
@property (strong , nonatomic) UIImageView *snapedImageView;

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
    
    self.collectionView0.backgroundColor = [UIColor clearColor];
    self.collectionView1.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    //长按
//    UILongPressGestureRecognizer * longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesAction:)];
//    longPressGes.delegate = self;
//    longPressGes.allowableMovement = YES;
//    longPressGes.minimumPressDuration = 1;
//    [self.collectionView1 addGestureRecognizer:longPressGes];

}

#pragma mark - config tableview
+ (CGFloat)configCell0HeightWithInfo:(CGFloat)cell0Height{

    return 302 + cell0Height;
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
        if (self.dataArray.count == 0) {
            self.noDataLabel.hidden = NO;
        }else{
            self.noDataLabel.hidden = YES;
        }
        return self.dataArray.count;
    }else{
        if (self.selectArray.count == 0) {
            self.noChooseView.hidden = NO;
        }else{
            self.noChooseView.hidden = YES;
        }
        return self.selectArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.collectionView0 == collectionView) {
        UserHeaderCell* headCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell0 forIndexPath:indexPath];
        
        CoustomerList * user = self.dataArray[indexPath.row];
        [headCell.avatarImageView0 yy_setImageWithURL:[NSURL URLWithString:user.faceUrl] placeholder:[UIImage imageNamed:@"placeholder"]];
        if (user.isSelectAvatar == YES) {
            [headCell.selectImage0 setImage:[UIImage imageNamed:@"user_customer_selecte"]];
        }else{
            [headCell.selectImage0 setImage:[UIImage imageNamed:@"user_customer_normal"]];
        }

        return headCell;
    }else{
        
        UserHeaderCell2* headCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell1 forIndexPath:indexPath];
        
        CoustomerList * user =  self.selectArray[indexPath.item];
        [headCell.showAvatarImage yy_setImageWithURL:[NSURL URLWithString:user.faceUrl] placeholder:[UIImage imageNamed:@"placeholder"]];
        
        if (indexPath.item == 0) {
            headCell.typeLabel.text = @"客户";
            [headCell.firstImageBoard setHidden:NO];
            [headCell.typeLabel setTextColor:[UIColor colorWithHexString:@"0A6DFE"]];
        }else{
            headCell.typeLabel.text = @"随行";
            [headCell.typeLabel setTextColor:[UIColor colorWithHexString:@"ADB3BD"]];
            [headCell.firstImageBoard setHidden:YES];
            
        }
        WS(weakSelf);
        [headCell.deleteButton setAction:^{
            //删除
            CoustomerList * user =  weakSelf.selectArray[indexPath.item];
            user.isSelectAvatar = NO;
            [weakSelf.selectArray removeObject:user];
            [weakSelf reloadCollectionViewData1];
            [weakSelf reloadCollectionViewData0];
        }];
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
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.collectionView0 == collectionView) {
        CoustomerList * user = self.dataArray[indexPath.item];
        //当前被选中 则反选
        if (user.isSelectAvatar) {
            user.isSelectAvatar = NO;
            if ([self.selectArray containsObject:user]) {
                [self.selectArray removeObject:user];
            }
        }else{
            user.isSelectAvatar = YES;
            if (![self.selectArray containsObject:user]) {
                [self.selectArray addObject:user];
            }
        }
        NSLog(@"已选数组- %@",self.selectArray);
        if (self.selectAvatarBlock) {
            self.selectAvatarBlock(self.selectArray);
        }

    }else{
        NSLog(@"cell1 ----- row %ld",indexPath.item);


        
    }
}

-(void)reloadCollectionViewData0{
    [self.collectionView0 reloadData];
}

-(void)reloadCollectionViewData1{
    [self.collectionView1 reloadData];
}

/****************************************************/
#pragma mark - 添加手势
/****************************************************/

-(void)longPressGesAction:(UIGestureRecognizer *)pressGes{

    //获取当前位置
    CGPoint location = [pressGes locationInView:self.collectionView1];
    
    // 当手指的位置不在collectionView的cell范围内时为nil
    NSIndexPath * notSureIndexPath = [self.collectionView1 indexPathForItemAtPoint:location];
    
    //获取当前cell
    UserHeaderCell2* cell = (UserHeaderCell2 *)[self.collectionView1 cellForItemAtIndexPath:notSureIndexPath];
    
    CGSize deltaSize = CGSizeMake(location.x - cell.frame.origin.x, location.y-cell.frame.origin.y);

    //state属性是所有手势父类提供的方法，用于记录手势的状态
    if(pressGes.state == UIGestureRecognizerStateBegan){
        NSLog(@"长按手势开始响应!");
        if (notSureIndexPath) {
            self.currentSelectIndex = notSureIndexPath;
            self.snapedImageView = cell.deleteTypeImage;
            self.snapedImageView.center = cell.center;
            [self.snapedImageView setTransform:CGAffineTransformScale(self.snapedImageView.transform, 1.1, 1.1)];
            cell.alpha = 0.0;
            [self.collectionView1 addSubview:self.snapedImageView];
            
        }
    }else if (pressGes.state == UIGestureRecognizerStateChanged){
        NSLog(@"长按手势状态发生改变!");
        if (self.snapedImageView == nil) {
            return;
        }
        
//        CGFloat pointX = location.x - deltaSize.width;
 
        
    }else{
        NSLog(@"长按手势结束!");
    }
}


-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
@end
