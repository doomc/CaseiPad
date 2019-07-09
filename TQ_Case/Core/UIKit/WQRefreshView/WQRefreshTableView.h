//
//  WQRefreshTableView.h
//  DNF
//
//  Created by Jayla on 16/2/3.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WQRefreshTableView;

NS_ASSUME_NONNULL_BEGIN

@protocol WQRefreshTableViewDataSource <NSObject>
@optional
- (MJRefreshHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block;
- (MJRefreshFooter *)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block;
@end

@protocol WQRefreshTableViewDelegate <NSObject>
@required

/**
 上拉加载和下拉刷新回调事件
 
 @param tableView 当前TableView
 @param pageIndex 加载页号（为0是即为下拉刷新）
 @param success   成功回调（传入当前页数据，页面将自动刷新）
 @param failure   失败回调（传入失败信息，页面将自动提示）
 */
- (void)tableView:(WQRefreshTableView *)tableView
        pageIndex:(NSUInteger)pageIndex
          success:(void (^)(NSArray * _Nullable list, BOOL hasNext))success
          failure:(void (^)(NSError *error))failure;
@end


@interface WQRefreshTableView : UITableView
@property (nonatomic, weak) IBOutlet id<WQRefreshTableViewDataSource> refreshDataSource;
@property (nonatomic, weak) IBOutlet id<WQRefreshTableViewDelegate> refreshDelegate;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) BOOL allowShowLoad;               //是否显示下拉加载（默认显示）
@property (nonatomic, assign) BOOL allowShowMore;               //是否显示加载更多（默认显示）
@property (nonatomic, assign) BOOL allowShowBlank;              //是否显示占位图（默认显示）
@property (nonatomic, assign) BOOL allowShowNoNetworkBlank;     //是否显示无网占位图（默认显示）
@property (nonatomic, strong, nullable) NSString *blankImage;
@property (nonatomic, strong, nullable) NSString *blankTitle;
@property (nonatomic, strong, nullable) NSString *blankMessage;

- (void)refreshData;
- (void)loadMoreData;

- (void)addRefreshHeader;
- (void)addRefreshFooter;

- (void)resetData:(NSArray *)data;
- (void)appendData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
