//
//  WQCollectionTableVC.m
//  LOL
//
//  Created by 李 青兆 on 14-9-19.
//  Copyright (c) 2014年 cheer. All rights reserved.
//

#import "WQCollectionTableView.h"
#import "UIView+L2.h"

@interface WQCollectionTableView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)NSMutableDictionary *numberInRowInSection;
@property (nonatomic, assign)CGFloat miniSpece;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation WQCollectionTableView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self creatSelf];
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
        [self creatSelf];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSelf];
    }
    return self;
}
-(void)creatSelf
{
    if (self.tableView==nil) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.tableView.origin = CGPointZero;
        [self addSubview:self.tableView];
    }
    [self reloadData];
}
-(void)setDelegate:(id<WQCollectionTableVCDelegate>)delegate
{
    _delegate = delegate;
    [self reloadData];
}
-(void)reloadData
{
    self.numberInRowInSection = [NSMutableDictionary dictionaryWithCapacity:0];
    self.miniSpece = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewMinimumInteritemSpacing:)]) {
        self.miniSpece = [self.delegate collectionViewMinimumInteritemSpacing:self];
    }
    int number = 1;
    NSInteger sectionCount = [self.delegate numberOfSectionsInCollectionView:self];
    for (int i=0; i<sectionCount; i++) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:sizeForItemAtIndexPath:)]) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            CGSize size = [self.delegate collectionView:self sizeForItemAtIndexPath:indexPath];
            number = (int)(self.tableView.frame.size.width-self.leftMargen)/(size.width+self.miniSpece);
            if (number<1) {
                number = 1;
            }
        }
        NSString *key = [NSString stringWithFormat:@"%d",i];
        [self.numberInRowInSection setObject:[NSNumber numberWithInt:number] forKey:key];
    }
    
    
    [self.tableView reloadData];
}
-(UIView *)itemViewAtIndex:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%d",(int)indexPath.section];
    NSInteger number = [self.numberInRowInSection[key] integerValue];
    NSIndexPath *tempIndex = [NSIndexPath indexPathForRow:indexPath.row/number inSection:indexPath.section];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:tempIndex];
    UIView *content = [cell.contentView viewWithTag:1000+(indexPath.row%number)];
    return content;
}
/**********************************************************************/
#pragma mark - UITableViewDataSource
/**********************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.delegate numberOfSectionsInCollectionView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger count = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        count = [self.delegate collectionView:self numberOfItemsInSection:section];
    }
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    NSInteger number = [self.numberInRowInSection[key] integerValue];
    if (number == 0) {
        return 0;
    }
    count = count/number+(count%number!=0);
    if (section==[self numberOfSectionsInTableView:self.tableView]-1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewNeedMore:)]) {
            BOOL needMore = [self.delegate collectionViewNeedMore:self];
            count +=needMore;
        }
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView normalCell:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *key = [NSString stringWithFormat:@"%d",(int)indexPath.section];
    NSInteger number = [self.numberInRowInSection[key] integerValue];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        for (int i=0; i<number; i++) {
            NSIndexPath *itemIndex = [NSIndexPath indexPathForRow:indexPath.row*number+i inSection:indexPath.section];
            UIView *content = [self.delegate collectionView:self cellForItemAtIndexPath:itemIndex];
            content.customObj = itemIndex;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelectedItem:)];
            gesture.delegate = self;
            [content addGestureRecognizer:gesture];
            content.tag = 1000+i;
            CGFloat width = self.frame.size.width/number;
            CGSize size = [self.delegate collectionView:self sizeForItemAtIndexPath:itemIndex];
            if (self.miniSpece==0 && self.leftMargen == 0) {
                content.frame = CGRectMake(i*width+(width-size.width)/2 , 0, size.width, size.height);
            }else{
                content.frame = CGRectMake(i*(size.width+self.miniSpece)+self.leftMargen,0, size.width, size.height);
            }
            
            [cell.contentView addSubview:content];
        }
    }
    NSInteger count = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        count = [self.delegate collectionView:self numberOfItemsInSection:indexPath.section];
    }
    for (int i=0; i<number; i++) {
        NSIndexPath *itemIndex = [NSIndexPath indexPathForRow:indexPath.row*number+i inSection:indexPath.section];
        UIView *content = [cell.contentView viewWithTag:1000+i];
        if (itemIndex.row>=count) {
            content.hidden = YES;
        }else{
            content.hidden = NO;
            content.customObj = itemIndex;
            [self.delegate collectionView:self setContentView:content ForIndex:itemIndex];
        }
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%d",(int)indexPath.section];
    NSInteger number = [self.numberInRowInSection[key] integerValue];
    NSInteger count = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        count = [self.delegate collectionView:self numberOfItemsInSection:indexPath.section];
    }
    count = count/number+(count%number!=0);
    if (count>indexPath.row) {
        return [self tableView:tableView normalCell:indexPath];
    }else{
        UITableViewCell *cell = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewMoreCell:)]) {
            cell = [self.delegate collectionViewMoreCell:self];
        }
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moremore"];
        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:sizeForItemAtIndexPath:)]) {
        NSIndexPath *itemIndex = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        CGSize size = [self.delegate collectionView:self sizeForItemAtIndexPath:itemIndex];
        return size.height;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:heightForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.delegate collectionView:self heightForSupplementaryElementOfKind:@"head" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:heightForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.delegate collectionView:self heightForSupplementaryElementOfKind:@"footer" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.delegate collectionView:self viewForSupplementaryElementOfKind:@"head" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.delegate collectionView:self viewForSupplementaryElementOfKind:@"footer" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewShowCell:)]) {
        [self.delegate collectionViewShowCell:cell];
    }
}
-(void)onSelectedItem:(UITapGestureRecognizer *)gesture
{
    UIView *content = gesture.view;
    self.selectedIndexPath = content.customObj;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:self didSelectItemAtIndexPath:content.customObj];
    }
}
#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:touchedItem:atIndexPath:)]) {
        UIView *content = gestureRecognizer.view;
        [self.delegate collectionView:self touchedItem:content atIndexPath:content.customObj];
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.state==UIGestureRecognizerStateFailed) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:touchCancelItem:atIndexPath:)]) {
            UIView *content = gestureRecognizer.view;
            [self.delegate collectionView:self touchCancelItem:content atIndexPath:content.customObj];
        }
    }
    return YES;
}

#pragma mark - UIScrollView delegate
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if (scrollView==self.tableView) {
//        NSMutableDictionary * dict = [NSMutableDictionary new];
//        [dict setObject:[NSNumber numberWithFloat:velocity.y] forKey:@"velocityY"];
//        [dict setObject:[NSNumber numberWithFloat:targetContentOffset->y] forKey:@"ContentOffsetY"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:tableBarAnimation object:dict];
//    }
//}
@end
