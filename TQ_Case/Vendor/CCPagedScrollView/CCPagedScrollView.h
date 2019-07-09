//
//  CCPagedScrollView.h
//  CCPagedScrollView
//
//  Created by robbie on 14-8-15.
//  Copyright (c) 2014年 wenri365. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMPageControl.h"
@class CCPagedScrollViewItem;

@protocol CCPagedScrollViewDelegate <NSObject>

- (void)ccPagedScrollViewTap:(CCPagedScrollViewItem *)item;

@end

@interface CCPagedScrollView : UIView

//适配数据
@property(strong,nonatomic) NSArray *items  ;
@property(strong,nonatomic) SMPageControl   *pageControl;
@property(strong,nonatomic) UIView  *pageView;
@property(strong,nonatomic) UIImageView *shadowImageView;
@property(strong,nonatomic) UIScrollView    *scrollView;
@property (nonatomic, assign)id <CCPagedScrollViewDelegate> delegate;
@property(strong, nonatomic) UIImage *defaulImage;
@property(assign, nonatomic) BOOL showTitle;

-(id)initWithFrame:(CGRect)frame
 animationDuration:(NSTimeInterval)animationDuration
            isAuto:(BOOL)isAuto;
-(void)buildCCPagedScrollViewWithFrame:(CGRect)rect;
//设置轮播View
-(void)setupViews ;

//重新轮播
-(void)restartAuto ;
//取消轮播
-(void)stopAuto ;
//指定移动位置
-(void)scrollToIndex:(NSInteger)aIndex ;

/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(CCPagedScrollViewItem *item);

/**
 切换界面的时候，执行的block
 **/
@property (nonatomic , copy) void (^CurrentIndexBlock)(CCPagedScrollViewItem *item);

@end

//辅助信息
@interface CCPagedScrollViewItem : NSObject<NSCopying>

@property (nonatomic, assign)NSInteger  itemTag;
@property (nonatomic, strong)NSString   *itemImageUrl;
@property (nonatomic, strong)UIImage    *itemImage;
@property (nonatomic, strong)NSString   *title;
@property (nonatomic, assign)NSInteger   type;//（0 无效果  1 跳车辆详情  2 跳H5）


-(id)initWithItemImageUrl:(NSString *)itemImageUrl itemTag:(NSInteger)tag ;
-(id)initWithItemImage:(UIImage *)itemImage itemTag:(NSInteger)tag ;

@end
