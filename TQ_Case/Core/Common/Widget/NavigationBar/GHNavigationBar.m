//
//  GHNavigationBar.m
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/30.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import "GHNavigationBar.h"

@implementation GHNavigationBar

/**********************************************************************/
#pragma mark - Action
/**********************************************************************/

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.totalHeight.constant = kStatusBarHeight + kNavBarHeight;
    self.navbarHeight.constant = kNavBarHeight;
    self.lineHeight.constant = 1.f;
    
    [self.lineView setBackgroundColor:RGB(222, 222, 222)];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.titleLabel setTextColor:RGB(53, 53, 53)];
    self.backButtonWidth.constant = 50.f;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.lineView setHidden:NO];
}


@end
