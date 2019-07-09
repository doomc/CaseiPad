//
//  UIView+Blank.m
//  DNF
//
//  Created by Jayla on 16/2/23.
//  Copyright © 2016年 anzogame. All rights reserved.
//

#import "UIView+Blank.h"

@implementation UIView (Blank)

static const char *__blankView__ = "__blankView__";
static const char *__blankAction__ = "__blankAction__";

- (WQBlankView *)showBlankWithAction:(void (^)(void))action insets:(UIEdgeInsets)insets {
    WQBlankView *blankView = objc_getAssociatedObject(self, __blankView__);
    if (blankView == nil) {
        blankView = [[WQBlankView alloc] init];
        blankView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [blankView addTarget:self action:@selector(__blankAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:blankView];
        objc_setAssociatedObject(self, __blankView__, blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, __blankAction__, action, OBJC_ASSOCIATION_COPY);
    
    //修正TableView上对header和footer的遮挡
    CGRect frame = self.bounds;
    if ([self isKindOfClass:[UITableView class]]) {
//        UITableView *tableView = (UITableView *)self;
//        frame.origin.y += tableView.tableHeaderView.height;
//        frame.size.height -= tableView.tableHeaderView.height + tableView.tableFooterView.height;
    }
    
    frame = UIEdgeInsetsInsetRect(CGRectMake(0, 0, frame.size.width, frame.size.height), insets);
    blankView.frame = frame;
    return blankView;
}
- (WQBlankView *)showBlankWithAction:(void (^)(void))action {
    return [self showBlankWithAction:action insets:UIEdgeInsetsZero];
}

- (void)dismissBlank {
    WQBlankView *blankView = objc_getAssociatedObject(self, __blankView__);
    [blankView removeFromSuperview];
    
    objc_setAssociatedObject(self, __blankView__, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, __blankAction__, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**********************************************************************/
#pragma mark - Action
/**********************************************************************/

- (void)__blankAction:(id)sender {
    void (^action)(void) = objc_getAssociatedObject(self, __blankAction__);
    if (action) {
        action();
    }
}

@end
