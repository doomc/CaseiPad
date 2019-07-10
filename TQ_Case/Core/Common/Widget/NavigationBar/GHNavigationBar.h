//
//  GHNavigationBar.h
//  GameHelper
//
//  Created by 青秀斌 on 2016/12/30.
//  Copyright © 2016年 kylincc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHNavigationBar : UIView

@property (nonatomic,weak) IBOutlet UIView *navView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UIView *lineView;
@property (nonatomic,weak) IBOutlet UIButton *backButton;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *totalHeight;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *navbarHeight;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *lineHeight;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *backButtonWidth;

@end
