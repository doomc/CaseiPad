//
//  WQBlankView.m
//  Pods
//
//  Created by Jayla on 16/4/22.
//
//

#import "WQBlankView.h"

static BOOL blankRefresh = NO;
static NSString *blankImage = nil;
static NSString *blankTitle = nil;
static NSString *blankMessage = nil;
static CGFloat blankOffset = 0;
static OffsetType blankOffsetType = OffsetTypeCenterY;

@interface WQBlankView () {
    CGFloat offsetY;
    OffsetType offsetType;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *refreshView;
@end

@implementation WQBlankView

- (instancetype)init {
    if (self = [super init]) {
        self.image(blankImage).title(blankTitle).message(blankImage).refresh(blankRefresh).offset(blankOffset, blankOffsetType);
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        switch (self->offsetType) {
            case OffsetTypeTop:
                make.top.equalTo(self).offset(self->offsetY);
                break;
            case OffsetTypeCenterY:
                make.centerY.equalTo(self).offset(self->offsetY);
                break;
            case OffsetTypeBottom:
                make.bottom.equalTo(self).offset(self->offsetY);
                break;
        } 
        make.left.greaterThanOrEqualTo(self).offset(20);
    }];
    
    UIView *tempView = nil;
    if (self.imageView) {
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
            make.left.greaterThanOrEqualTo(self.contentView);
        }];
        tempView = self.imageView;
    }
    
    if (self.titleLabel) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (tempView) {
                if (tempView == self.imageView) {
                    make.top.equalTo(tempView.mas_bottom).offset(20);
                } else {
                    make.top.equalTo(tempView.mas_bottom).offset(8);
                }
            } else {
                make.top.equalTo(self.contentView);
            }
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
        }];
        tempView = self.titleLabel;
    }
    
    if (self.messageLabel) {
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (tempView) {
                if (tempView == self.imageView) {
                    make.top.equalTo(tempView.mas_bottom).offset(20);
                } else {
                    make.top.equalTo(tempView.mas_bottom).offset(8);
                }
            } else {
                make.top.equalTo(self.contentView);
            }
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
        }];
        tempView = self.messageLabel;
    }
    
    if (self.refreshView) {
        [self.refreshView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (tempView) {
                if (tempView == self.imageView) {
                    make.top.equalTo(tempView.mas_bottom).offset(20);
                } else {
                    make.top.equalTo(tempView.mas_bottom).offset(16);
                }
            } else {
                make.top.equalTo(self.contentView);
            }
            make.centerX.equalTo(self.contentView);
            make.left.greaterThanOrEqualTo(self.contentView);
        }];
        tempView = self.refreshView;
    }
    
    [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
    }];
}

/**********************************************************************/
#pragma mark - Private
/**********************************************************************/

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}

/**********************************************************************/
#pragma mark - Public
/**********************************************************************/

- (BlankStringBlock)image {
    return ^WQBlankView *(NSString *image) {
        if (image) {
            if (!self.imageView) {
                self.imageView = [[UIImageView alloc] init];
                self.imageView.backgroundColor = [UIColor clearColor];
                [self.contentView addSubview:self.imageView];
            }
            self.imageView.image = [UIImage imageNamed:image];
        } else {
            if (self.imageView) {
                [self.imageView removeFromSuperview];
                self.imageView = nil;
            }
        }
        return self;
    };
}

- (BlankStringBlock)title {
    return ^WQBlankView *(NSString *title) {
        if (title) {
            if (!self.titleLabel) {
                self.titleLabel = [[UILabel alloc] init];
                self.titleLabel.textColor = RGB(199, 205, 211);
                self.titleLabel.backgroundColor = [UIColor clearColor];
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                self.titleLabel.font = [UIFont systemFontOfSize:14];
                self.titleLabel.numberOfLines = 2;
                [self.contentView addSubview:self.titleLabel];
            }
            self.titleLabel.text = title;
        } else {
            if (self.titleLabel) {
                [self.titleLabel removeFromSuperview];
                self.titleLabel = nil;
            }
        }
        return self;
    };
}

- (BlankStringBlock)message {
    return ^WQBlankView *(NSString *message) {
        if (message) {
            if (!self.messageLabel) {
                self.messageLabel = [[UILabel alloc] init];
                self.messageLabel.configText = @"T2";
                self.messageLabel.backgroundColor = [UIColor clearColor];
                self.messageLabel.textAlignment = NSTextAlignmentCenter;
                self.messageLabel.font = [UIFont systemFontOfSize:13];
                self.messageLabel.numberOfLines = 2;
                [self.contentView addSubview:self.messageLabel];
            }
            self.messageLabel.text = message;
        } else {
            if (self.messageLabel) {
                [self.messageLabel removeFromSuperview];
                self.messageLabel = nil;
            }
        }
        return self;
    };
}

- (BlankBoolBlock)refresh {
    return ^WQBlankView *(BOOL show) {
        if (show) {
            if (!self.refreshView) {
                self.refreshView = [UIView new];
                [self.contentView addSubview:self.refreshView];
                
                UIImageView *imageView = [UIImageView new];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.image = [UIImage imageNamed:@"sx"];
                [self.refreshView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.centerY.equalTo(self.refreshView);
                }];
                
                UILabel *label = [UILabel new];
                label.configText = @"T7";
                label.text = @"点击刷新";
                label.font = [UIFont boldSystemFontOfSize:12];
                [self.refreshView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.bottom.equalTo(self.refreshView);
                    make.left.equalTo(imageView.mas_right).offset(5);
                }];
            }
        } else {
            if (self.refreshView) {
                [self.refreshView removeFromSuperview];
                self.refreshView = nil;
            }
        }
        return self;
    };
}

- (BlankOffsetBlock)offset {
    return ^WQBlankView *(CGFloat offsetY, OffsetType offsetType) {
        offsetY = offsetY;
        offsetType = offsetType;
        [self setNeedsUpdateConstraints];
        [self setNeedsLayout];
        return self;
    };
}

+ (void)setBlankImage:(NSString *)image {
    blankImage = image;
}
+ (void)setBlankTitle:(NSString *)title {
    blankTitle = title;
}
+ (void)setBlankMessage:(NSString *)message {
    blankMessage = message;
}
+ (void)setBlankRefresh:(BOOL)refresh {
    blankRefresh = refresh;
}
+ (void)setBlankOffset:(CGFloat)offset type:(OffsetType)type; {
    blankOffset = offset;
    blankOffsetType = type;
}

@end
