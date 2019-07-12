//
//  PopViewController.m
//  TQ_Case
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "PopViewController.h"
#import "CounselorCell.h"

static NSString * const counselorCellId  = @"CounselorCell";

@interface PopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:counselorCellId bundle:nil] forCellWithReuseIdentifier:counselorCellId];
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**********************************************************************/
#pragma mark -UICollectionViewDataSource
/**********************************************************************/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CounselorCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:counselorCellId forIndexPath:indexPath];
    if (self.list) {
        CoustomerList * user = self.list[indexPath.row];
        [cell.name setText:user.name];
        [cell.headImage yy_setImageWithURL:[NSURL URLWithString:user.faceUrl] placeholder:[UIImage imageNamed:@"placeholder"]];
    }
    

    return cell;
}

/****************************************************/
#pragma mark --UICollectionViewDelegateFlowLayout
/****************************************************/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 100);
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
    
    NSLog(@"cell ----- row == %ld",indexPath.item);

    CoustomerList * user = self.list[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(delegateMethod:)]) {
        [self.delegate delegateMethod:user];
    }
}


@end
