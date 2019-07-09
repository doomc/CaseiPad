//
//  SSAutoresizeLabelFlowLayout.m
//  SSAutoresizeLabelFlow
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import "SSAutoresizeLabelFlowLayout.h"
#import "SSAutoresizeLabelFlowConfig.h"


@implementation SSAutoresizeLabelFlowLayout {
    UIEdgeInsets    contentInsets;
    CGFloat         itemHeight;
    CGFloat         itemSpace;
    CGFloat         lineSpace;
    CGFloat         itemMargin;
    UIFont          *titleFont;
    NSInteger       itemCount;
    currentOrigin   orgin;
}

- (void)prepareLayout {
    [super prepareLayout];
    SSAutoresizeLabelFlowConfig *config = [SSAutoresizeLabelFlowConfig shareConfig];
    
    contentInsets = config.contentInsets;
    titleFont = config.textFont;
    lineSpace = config.lineSpace;
    itemHeight = config.itemHeight;
    itemSpace = config.itemSpace;
    itemCount = [self.collectionView numberOfItemsInSection:0];
    itemMargin = config.textMargin;
    orgin.lineNumber = 0;
    orgin.lineX = contentInsets.left;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (NSInteger i = 0; i<attributesArray.count; i++) {
        UICollectionViewLayoutAttributes *att = attributesArray[i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSString *title = [self.dataSource titleForLabelAtIndexPath:indexPath];
        CGSize size = [self sizeWithTitle:title font:titleFont];
        CGFloat itemOrginX = orgin.lineX;
        CGFloat itemOrginY = orgin.lineNumber*(itemHeight+lineSpace) + contentInsets.top;
        CGFloat itemWidth = size.width + itemMargin;
        if (itemWidth > CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right)) {
            itemWidth = CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right);
        }
        att.frame = CGRectMake(itemOrginX, itemOrginY, itemWidth, itemHeight);
        orgin.lineX += itemWidth+itemSpace;
        if (i < attributesArray.count-1) {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:i+1 inSection:0];
            NSString *nextTitle = [self.dataSource titleForLabelAtIndexPath:nextIndexPath];
            CGSize nextSize = [self sizeWithTitle:nextTitle font:titleFont];
            if (nextSize.width+itemMargin > CGRectGetWidth(self.collectionView.frame)-contentInsets.right-orgin.lineX) {
                orgin.lineNumber ++;
                orgin.lineX = contentInsets.left;
            }
        }else {
            [self.delegate layoutFinishWithNumberOfline:orgin.lineNumber+1];
        }
    }
    return attributesArray;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    CGSize size = [title sizeWithFont:font byWidth:1000];
    return size;
}



@end
