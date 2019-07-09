//
//  UIPlaceHolderTextView.h
//  xbxm
//
//  Created by Scott Su on 14-12-6.
//  Copyright (c) 2014年 tongxueplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;

-(void)textChanged:(NSNotification*)notification;


@end
