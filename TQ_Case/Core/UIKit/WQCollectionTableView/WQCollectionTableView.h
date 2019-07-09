//
//  WQCollectionTableVC.h
//  LOL
//
//  Created by 李 青兆 on 14-9-19.
//  Copyright (c) 2014年 cheer. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WQCollectionTableView;

@protocol WQCollectionTableVCDelegate <NSObject>

@required
- (NSInteger)numberOfSectionsInCollectionView:(WQCollectionTableView *)collectionView;
- (NSInteger)collectionView:(WQCollectionTableView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UIView *)collectionView:(WQCollectionTableView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(WQCollectionTableView *)collectionView setContentView:(UIView *)contentView ForIndex:(NSIndexPath *)indexPath;
- (CGSize)collectionView:(WQCollectionTableView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

-(void)collectionView:(WQCollectionTableView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)collectionView:(WQCollectionTableView *)collectionView touchedItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath;
-(void)collectionView:(WQCollectionTableView *)collectionView touchCancelItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath;
- (UIView *)collectionView:(WQCollectionTableView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)collectionView:(WQCollectionTableView *)collectionView heightForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)collectionViewMinimumInteritemSpacing:(WQCollectionTableView *)collectionView;
-(BOOL)collectionViewNeedMore:(WQCollectionTableView *)collectionView;
-(UITableViewCell *)collectionViewMoreCell:(WQCollectionTableView *)collectionView;
-(void)collectionViewShowCell:(UITableViewCell *)cell;

@end


@interface WQCollectionTableView : UIView
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)IBOutlet id<WQCollectionTableVCDelegate> delegate;
@property (nonatomic, assign)CGFloat leftMargen;
@property (nonatomic, readonly) NSIndexPath *selectedIndexPath;

-(void)reloadData;
-(UIView *)itemViewAtIndex:(NSIndexPath *)index;
@end
