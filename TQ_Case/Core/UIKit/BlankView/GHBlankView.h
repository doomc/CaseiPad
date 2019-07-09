//
//  GHBlankView.h
//  GameHelper
//
//  Created by 青秀斌 on 16/12/29.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHBlankView;

NS_ASSUME_NONNULL_BEGIN

typedef GHBlankView * _Nonnull(^BlankImageBlock)(NSString * _Nullable);
typedef GHBlankView * _Nonnull(^BlankTextBlock)(NSString * _Nullable);
typedef GHBlankView * _Nonnull(^BlankOffsetBlock)(CGFloat);

@interface GHBlankView : UIView
@property (nonatomic, readonly) BlankImageBlock image;
@property (nonatomic, readonly) BlankTextBlock title;
@property (nonatomic, readonly) BlankTextBlock message;
@property (nonatomic, readonly) BlankOffsetBlock offsetY;
@end

NS_ASSUME_NONNULL_END
