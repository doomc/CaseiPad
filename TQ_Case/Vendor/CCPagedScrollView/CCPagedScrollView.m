//
//  CCPagedScrollView.m
//  CCPagedScrollView
//
//  Created by robbie on 14-8-15.
//  Copyright (c) 2014年 wenri365. All rights reserved.
//

#import "CCPagedScrollView.h"

//轮播图 没有view复用 所以轮播的图片不易太多页

@interface CCPagedScrollView()<UIScrollViewDelegate>
{
@private
    
    
    UILabel         *_countLabel;
    BOOL            _isAutoPlay ;
    NSTimeInterval  _animationDuration;
}



//切换界面
-(void)switchViewItems ;

//移动到指定位置
-(void)moveToTargetPosition:(CGFloat)targetX ;

@end

@implementation CCPagedScrollView

-(void)dealloc
{
    [self stopAuto] ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildCCPagedScrollViewWithFrame:frame];
        _animationDuration = 3.0;
        _isAutoPlay = YES;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
 animationDuration:(NSTimeInterval)animationDuration
            isAuto:(BOOL)isAuto
{
    self = [self initWithFrame:frame];
    
    _animationDuration = animationDuration ;
    _isAutoPlay = isAuto ;
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //    [self buildCCPagedScrollViewWithFrame:CGRectNull] ;
    _animationDuration = 3.0;
    _isAutoPlay = YES;
}

#pragma mark - settor
-(void)setItems:(NSArray *)items
{
    NSInteger count = [items count] ;
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:count+2];
    
    //添加最后一张图 用于循环
    if (count > 1)
    {
        CCPagedScrollViewItem *item = [items[count -1] copy] ;
        [itemArray addObject:item];
    }
    for (int i = 0; i < count; i++)
    {
        [itemArray addObject:items[i]];
    }
    //添加第一张图 用于循环
    if (count >1)
    {
        CCPagedScrollViewItem *item = [items[0] copy] ;
        [itemArray addObject:item];
    }
    _items = itemArray ;
    
    [self setupViews] ;
}

#pragma mark - public
-(void)stopAuto
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchViewItems) object:nil];
}

-(void)restartAuto
{
    if ([_items count]>1 && _isAutoPlay)
    {
        [self performSelector:@selector(switchViewItems) withObject:nil afterDelay:_animationDuration];
    }
}

-(void)scrollToIndex:(NSInteger)aIndex
{
    if ([_items count]>1)
    {
        if (aIndex >= ([_items count]-2))
        {
            aIndex = [_items count]-3;
        }
        [self moveToTargetPosition:self.bounds.size.width*(aIndex+1)];
    }else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
}

-(void)buildCCPagedScrollViewWithFrame:(CGRect)rect{
    if (CGRectEqualToRect(rect, CGRectNull)) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [UIScreen mainScreen].bounds.size.width, self.frame.size.height*[UIScreen mainScreen].bounds.size.width/self.frame.size.width + 1)];
        
    }else{
        _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    }
    _scrollView.scrollsToTop = NO;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    _pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0,
                                                                   _scrollView.bounds.size.height - 10 - 5,
                                                                   _scrollView.bounds.size.width,
                                                                   8)];
    
//    [_pageControl setPageIndicatorImage:[UIImage imageWithColor:RGBA(255, 255, 255, 0.3) size:CGSizeMake(3, 3)]];
//    [_pageControl setCurrentPageIndicatorImage:[UIImage imageWithColor:RGBA(255, 255, 255, 1) size:CGSizeMake(3, 3)]];
    [_pageControl setPageIndicatorTintColor:RGBA(255, 255, 255, 0.3)];
    [_pageControl setCurrentPageIndicatorTintColor:RGBA(255, 255, 255,1)];
    [_pageControl setIndicatorDiameter:5];
    
    //    [_pageControl setBackgroundColor:[UIColor clearColor]];
    //    [_pageControl setPageIndicatorImage:[UIImage imageNamed:@"home_advder_nor"]];
    //    [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"home_advder_hl"]];
    
    //    _pageControl.currentPageIndicatorTintColor = RGBA(255, 255, 255, 1) ;
    //    _pageControl.pageIndicatorTintColor =  RGBA(255, 255, 255, 0.5) ;
    _pageControl.userInteractionEnabled = NO;
    
    
    _pageView = [[UIView alloc] init];
    [_pageView setFrame:CGRectMake(_scrollView.bounds.size.width - 10 - 40, _scrollView.bounds.size.height - 12 - 15, 40, 15)];
    [_pageView setBackgroundColor:[UIColor clearColor]];
    //    [_pageView setCorner:7.5];
    [_pageView setClipsToBounds:YES];
    
    UIImageView *pageImageView = [[UIImageView alloc] initWithFrame:_pageView.bounds];
    [pageImageView setBackgroundColor:RGBA(0, 0, 0, 0.5)];
    [_pageView addSubview:pageImageView];
    [_pageView setHidden:YES];
    
    _countLabel = [[UILabel alloc] initWithFrame:_pageView.bounds];
    [_countLabel setFont:[UIFont systemFontOfSize:10]];
    [_countLabel setTextColor:[UIColor whiteColor]];
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    [_countLabel setBackgroundColor:[UIColor clearColor]];
    [_countLabel setText:@""];
    [_pageView addSubview:_countLabel];
    
    
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setFrame:CGRectMake(0, _scrollView.bounds.size.height - 60, SCREEN_WIDTH, 60)];
    [_shadowImageView setImage:[UIImage imageNamed:@"car_detailed_shadow"]];
    [_shadowImageView setHidden:YES];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    [self addSubview:_shadowImageView];
    [self addSubview:_pageView];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
}


-(void)setupViews
{
    [self setBackgroundColor:[UIColor clearColor]];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(superview)] ;
    
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)] ;
    
    _pageControl.numberOfPages = [_items count]>1?[_items count] -2:[_items count];
    _pageControl.currentPage = 0;
    
    if(_pageControl.numberOfPages == 0){
        [_countLabel setText:[NSString stringWithFormat:@"%ld/%ld",_pageControl.currentPage ,_pageControl.numberOfPages]];
    }else{
        [_countLabel setText:[NSString stringWithFormat:@"%ld/%ld",_pageControl.currentPage + 1,_pageControl.numberOfPages]];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * [_items count], _scrollView.frame.size.height);
    
    for (int i = 0; i < [_items count]; i++)
    {
        
        CCPagedScrollViewItem *item = _items[i];
        
        CGRect frame = CGRectMake(i * _scrollView.frame.size.width,
                                  0,
                                  _scrollView.frame.size.width,
                                  _scrollView.frame.size.height) ;
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        
        imageView.backgroundColor = RGB(247, 247, 247);
        imageView.clipsToBounds = YES ;
        [_scrollView addSubview:imageView];
        
        CGSize size = [item.title sizeWithFont:[UIFont systemFontOfSize:18] byWidth:(SCREEN_WIDTH - 36)];
        
        
        if (self.showTitle) {
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x + 18, frame.size.height - size.height - 30, (SCREEN_WIDTH - 36), size.height)];
            [titleLable setText:item.title];
            [titleLable setNumberOfLines:0];
            [titleLable setFont:[UIFont systemFontOfSize:18]];
            [titleLable setTextColor:[UIColor whiteColor]];
            [titleLable setBackgroundColor:[UIColor clearColor]];
            [_scrollView addSubview:titleLable];
        }
        if(item.itemImage)
        {
            imageView.image = item.itemImage ;
        }else
        {
            if(item.itemImageUrl && [item.itemImageUrl length]>0)
            {
                UIImage *deImage;
                if (self.defaulImage) {
                    deImage = self.defaulImage;
                }else{
                    deImage = [UIImage imageNamed:@"img_default_banner_bg"];
                }
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                [imageView yy_setImageWithURL:[NSURL URLWithString:item.itemImageUrl] placeholder:deImage];
            }
        }
    }
    if ([_items count]>1)
    {
        [_pageControl setHidden:NO];
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO] ;
        [self restartAuto] ;
    }else{
        [_pageControl setHidden:YES];
    }
}

-(void)switchViewItems
{
    [self stopAuto] ;
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    
    targetX = (int)(targetX/self.bounds.size.width) * self.bounds.size.width;
    [self moveToTargetPosition:targetX];
    
    [self restartAuto] ;
}

-(void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

#pragma mark -actions
-(void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < [_items count])
    {
        CCPagedScrollViewItem *item = _items[page] ;
        if(self.TapActionBlock)
        {
            self.TapActionBlock(item) ;
        }else if (self.delegate && [self.delegate respondsToSelector:@selector(ccPagedScrollViewTap:)]){
            [self.delegate ccPagedScrollViewTap:item];
        }
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float targetX = scrollView.contentOffset.x;
    if ([_items count]>=3)
    {
        if (targetX >= self.bounds.size.width * ([_items count] -1))
        {
            targetX = self.bounds.size.width ;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = self.bounds.size.width  *([_items count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    
    NSInteger page = (_scrollView.contentOffset.x+self.bounds.size.width /2.0) / self.bounds.size.width ;
    
    if ([_items count] > 1)
    {
        page --;
        if (page >= _pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pageControl.numberOfPages -1;
        }
    }
    if (page!= _pageControl.currentPage)
    {
        if(self.CurrentIndexBlock)
        {
            CCPagedScrollViewItem *item = _items[page] ;
            self.CurrentIndexBlock(item) ;
        }
    }
    _pageControl.currentPage = page;
    if(_pageControl.numberOfPages == 0){
        [_countLabel setText:[NSString stringWithFormat:@"%ld/%ld",page ,_pageControl.numberOfPages]];
    }else{
        [_countLabel setText:[NSString stringWithFormat:@"%ld/%ld",page + 1,_pageControl.numberOfPages]];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self restartAuto];
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/self.bounds.size.width) * self.bounds.size.width;
        [self moveToTargetPosition:targetX];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAuto];
}

@end


//============
@implementation CCPagedScrollViewItem


-(id)initWithItemImageUrl:(NSString *)itemImageUrl itemTag:(NSInteger)tag
{
    return [self initWithItemImage:nil WithItemImageUrl:itemImageUrl itemTag:tag];
}
-(id)initWithItemImage:(UIImage *)itemImage itemTag:(NSInteger)tag
{
    return [self initWithItemImage:itemImage WithItemImageUrl:nil itemTag:tag];
}

-(id)initWithItemImage:(UIImage *)itemImage WithItemImageUrl:(NSString *)itemImageUrl itemTag:(NSInteger)tag
{
    self = [self init];
    if(self)
    {
        self.itemImage = itemImage ;
        self.itemImageUrl = itemImageUrl ;
        self.itemTag = tag ;
    }
    return self ;
}

-(id)copyWithZone:(NSZone *)zone
{
    CCPagedScrollViewItem *itemCopy = [[CCPagedScrollViewItem allocWithZone:zone]init];
    itemCopy.itemTag = _itemTag ;
    itemCopy.itemImage = [_itemImage copy] ;
    itemCopy.itemImageUrl = [_itemImageUrl copy] ;
    return itemCopy;
}

@end
