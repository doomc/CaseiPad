//
//  OpenScreenController.h
//  VMoive
//
//  Created by Sunyi on 15/11/17.
//  Copyright © 2015年 Beijing VMovie Technology. All rights reserved.
//

#import "BSViewController.h"

@class OpenScreenController;

@protocol OpenScreenControllerDelegate <NSObject>

@optional;
- (void)openScreenControllerDisMis:(OpenScreenController *)openScreenController;

@end

@interface OpenScreenController : BSViewController

@property (assign, nonatomic) id<OpenScreenControllerDelegate> delegate;

@end
