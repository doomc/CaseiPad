//
//  WQBlankView.h
//  Pods
//
//  Created by Jayla on 16/4/22.
//
//

#import <UIKit/UIKit.h>
@class WQBlankView;

typedef NS_ENUM(NSUInteger, OffsetType) {
    OffsetTypeCenterY,
    OffsetTypeTop,
    OffsetTypeBottom,
};

NS_ASSUME_NONNULL_BEGIN

typedef WQBlankView * _Nonnull(^BlankStringBlock)(NSString * _Nullable);
typedef WQBlankView * _Nonnull(^BlankOffsetBlock)(CGFloat, OffsetType);
typedef WQBlankView * _Nonnull(^BlankBoolBlock)(BOOL);

@interface WQBlankView : UIControl
@property (copy, nonatomic, readonly) BlankStringBlock image;
@property (copy, nonatomic, readonly) BlankStringBlock title;
@property (copy, nonatomic, readonly) BlankStringBlock message;
@property (copy, nonatomic, readonly) BlankOffsetBlock offset;
@property (copy, nonatomic, readonly) BlankBoolBlock refresh;

+ (void)setBlankImage:(nullable NSString *)image;
+ (void)setBlankTitle:(nullable NSString *)title;
+ (void)setBlankMessage:(nullable NSString *)message;
+ (void)setBlankRefresh:(BOOL)refresh;
+ (void)setBlankOffset:(CGFloat)offset type:(OffsetType)type;
@end

NS_ASSUME_NONNULL_END
