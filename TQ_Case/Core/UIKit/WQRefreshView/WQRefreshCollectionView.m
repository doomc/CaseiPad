//
//  WQRefreshCollectionView.m
//  DNF
//
//  Created by Jayla on 16/2/19.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import "WQRefreshCollectionView.h"
#import "WQRefreshHeader.h"
#import "WQRefreshFooter.h"
#import "UIView+Blank.h"

typedef void (^LoadSuccessBlock)(NSArray * _Nullable list, BOOL hasNext, BOOL isRefresh);
typedef void (^LoadFailureBlock)(NSError *error);

@interface WQRefreshCollectionView ()
@property (nonatomic, copy) LoadSuccessBlock successBlock;
@property (nonatomic, copy) LoadFailureBlock failureBlock;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger pageIndex;
@end

@implementation WQRefreshCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.pageIndex = 0;
    self.allowShowLoad = YES;
    self.allowShowMore = YES;
    self.allowShowBlank = YES;
    self.allowShowNoNetworkBlank = YES;
    self.blankImage = nil;
    self.blankTitle = nil;
    self.blankMessage = nil;
    
    [self initBlock];
}
- (void)initBlock {
    
    @weakify(self)
    self.successBlock = ^(NSArray * _Nullable list, BOOL hasNext, BOOL isRefresh) {
        @strongify(self)
        [self.mj_header endRefreshing];
        
        //改变数据
        if (isRefresh) {
            if (hasNext) {
                [self addRefreshFooter];
            }
            [self resetData:list];
        } else {
            [self appendData:list];
        }
        
        //改变状态
        if (hasNext) {
            [self.mj_footer endRefreshing];
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    };
    
    self.failureBlock = ^(NSError *error) {
        @strongify(self)
        [self.mj_header endRefreshing];
        
        //显示占位图
        if (self.dataArray.count > 0) {
            self.mj_footer.hidden = NO;
            [self dismissBlank];
        } else {
            self.mj_footer.hidden = YES;
            if (self.allowShowBlank) {
                NSString *blankTitle = error.localizedDescription?:self.blankTitle;
                if (self.allowShowNoNetworkBlank && ![AFNetworkReachabilityManager sharedManager].isReachable) {
                    [self showBlankWithAction:nil].image(@"no_network").title(@"网络已断开，请连接后重试");
                } else {
                    [self showBlankWithAction:nil].image(@"failed_to_load").title(blankTitle?:@"加载失败").image(self.blankMessage);
                }
            }
        }
    };
}

- (void)setRefreshDelegate:(id<WQRefreshCollectionViewDelegate>)refreshDelegate {
    _refreshDelegate = refreshDelegate;
    
    if ([self.refreshDelegate respondsToSelector:@selector(collectionView:pageIndex:success:failure:)]) {
        [self addRefreshHeader];
    }
}

- (void)setAllowShowMore:(BOOL)allowShowMore {
    _allowShowMore = allowShowMore;
    
    if (!allowShowMore && self.mj_footer) {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
}

/**********************************************************************/
#pragma mark - Private
/**********************************************************************/

- (void)addRefreshHeader {
    if (!self.allowShowLoad) {
        return;
    }
    if (self.mj_header) {
        return;
    }
    
    @weakify(self)
    MJRefreshComponentRefreshingBlock block = ^{
        @strongify(self)
        NSUInteger pageIndex = 0;
        [self.refreshDelegate collectionView:self pageIndex:pageIndex success:^(NSArray * _Nullable list, BOOL hasNext) {
            @strongify(self)
            self.successBlock(list, hasNext, YES);
        } failure:^(NSError * _Nonnull error) {
            @strongify(self)
            self.failureBlock(error);
        }];
    };
    
    MJRefreshHeader *header = nil;
    if ([self.refreshDelegate respondsToSelector:@selector(headerWithRefreshingBlock:)]) {
        header = [self.refreshDataSource headerWithRefreshingBlock:block];
    } else {
        header = [WQRefreshHeader headerWithRefreshingBlock:block];
    }
    self.mj_header = header;
}

- (void)addRefreshFooter {
    if (!self.allowShowMore) {
        return;
    }
    if (self.mj_footer) {
        return;
    }
    
    @weakify(self)
    MJRefreshComponentRefreshingBlock block = ^{
        @strongify(self)
        NSUInteger pageIndex = self.pageIndex + 1;
        [self.refreshDelegate collectionView:self pageIndex:pageIndex success:^(NSArray * _Nullable list, BOOL hasNext) {
            @strongify(self)
            self.successBlock(list, hasNext, NO);
        } failure:^(NSError * _Nonnull error) {
            @strongify(self)
            self.failureBlock(error);
        }];
    };
    
    MJRefreshFooter *footer = nil;
    if ([self.refreshDelegate respondsToSelector:@selector(footerWithRefreshingBlock:)]) {
        footer = [self.refreshDataSource footerWithRefreshingBlock:block];
    } else {
        footer = [WQRefreshFooter footerWithRefreshingBlock:block];
    }
    self.mj_footer = footer;
}

/**********************************************************************/
#pragma mark - Public
/**********************************************************************/

- (void)refreshData {
    [self addRefreshHeader];
    
    BOOL isRefreshing = self.mj_header.isRefreshing;
    if (!isRefreshing) {
        [self.mj_header beginRefreshing];
    }
}

- (void)loadMoreData {
    [self addRefreshFooter];
    
    BOOL noMoreData = self.mj_footer.state != MJRefreshStateNoMoreData;
    BOOL isRefreshing = self.mj_footer.isRefreshing;
    if (!noMoreData && !isRefreshing) {
        [self.mj_footer beginRefreshing];
    }
}

- (void)resetData:(NSArray *)list {
    self.pageIndex = 0;
    self.dataArray = [list mutableCopy];
    [self reloadData];
    
    //显示占位图
    if (self.dataArray.count > 0) {
        self.mj_footer.hidden = NO;
        [self dismissBlank];
    } else {
        self.mj_footer.hidden = YES;
        if (self.allowShowBlank) {
            [self showBlankWithAction:nil].image(self.blankImage?:@"common_empty_Icon").title(self.blankTitle?:@"暂无数据").image(self.blankMessage);
        }
    }
}

- (void)appendData:(NSArray *)list {
    self.pageIndex++;
    [self.dataArray addObjectsFromArray:list];
    [self reloadData];
    
    //显示占位图
    if (self.dataArray.count > 0) {
        self.mj_footer.hidden = NO;
        [self dismissBlank];
    } else {
        self.mj_footer.hidden = YES;
        if (self.allowShowBlank) {
            [self showBlankWithAction:nil].image(self.blankImage?:@"common_empty_Icon").title(self.blankTitle?:@"暂无数据").image(self.blankMessage);
        }
    }
}

@end
