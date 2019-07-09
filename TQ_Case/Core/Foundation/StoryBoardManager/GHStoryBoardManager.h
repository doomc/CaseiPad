//
//  StoryBoardManager.h
//  HeMu
//
//  Created by sky on 2019/2/26.
//  Copyright © 2019年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHStoryBoardManager : NSObject

@property (nonatomic, strong) UIStoryboard *homeStoryBoard;
@property (nonatomic, strong) UIStoryboard *settingStoryBoard;
@property (nonatomic, strong) UIStoryboard *loginStoryBoard;
@property (nonatomic, strong) UIStoryboard *messageStoryBoard;
@property (nonatomic, strong) UIStoryboard *mineStoryBoard;

@end

NS_ASSUME_NONNULL_END
