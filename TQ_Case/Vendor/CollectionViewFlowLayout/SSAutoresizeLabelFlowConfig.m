//
//  SSAutoresizeLabelFlowConfig.m
//  SSAutoresizeLabelFlow
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import "SSAutoresizeLabelFlowConfig.h"
#import "SSAutoresizeLabelFlowLayout.h"

@implementation SSAutoresizeLabelFlowConfig


+ (SSAutoresizeLabelFlowConfig *)shareConfig{
    static SSAutoresizeLabelFlowConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
    });
    return config;
}

// default

- (instancetype)init{
    self = [super init];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(15, 0, 15, 0);
        self.lineSpace = 10;
        self.itemHeight = 14;
        self.itemSpace = 10;
        self.textMargin = 0;
        self.textFont = [UIFont systemFontOfSize:11];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)initCarRentState{
    self.contentInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    self.lineSpace = 10;
    self.itemHeight = 30;
    self.itemSpace = 10;
    self.textMargin = 42;
    self.textFont = [UIFont systemFontOfSize:12];
    self.backgroundColor = [UIColor clearColor];
}

- (CGFloat)configHeight:(NSMutableArray *)dataArray screenWidth:(CGFloat)screenWidth{
    CGFloat height = 0;
    currentOrigin orgin;
    orgin.lineNumber = 0;
    orgin.lineX = 0;
    SSAutoresizeLabelFlowConfig *config = [SSAutoresizeLabelFlowConfig shareConfig];
    for (NSInteger i = 0; i<dataArray.count; i++) {
        NSString *title = [dataArray objectAtIndex:i];
        CGSize size = [title sizeWithFont:config.textFont byWidth:1000];
        size.width = (int)size.width;
        
        CGFloat itemWidth = size.width + config.textMargin;
        if (itemWidth > (screenWidth)-(config.contentInsets.left + config.contentInsets.right)) {
            itemWidth = (screenWidth)-(config.contentInsets.left + config.contentInsets.right);
        }
        orgin.lineX += itemWidth + config.itemSpace;
        if (i < dataArray.count - 1) {
            NSString *nextTitle = [dataArray objectAtIndex:(i+1)];
            CGSize nextSize = [nextTitle sizeWithFont:config.textFont byWidth:1000];
            nextSize.width = (int)nextSize.width;
            if (nextSize.width + config.textMargin > screenWidth - config.contentInsets.right - orgin.lineX) {
                orgin.lineNumber ++;
                orgin.lineX = config.contentInsets.left;
            }
        }else {
            NSInteger number =  orgin.lineNumber + 1;
            height = config.contentInsets.top + config.contentInsets.bottom + config.itemHeight * number+config.lineSpace * (number - 1);
        }
    }
    return height;
}

@end
