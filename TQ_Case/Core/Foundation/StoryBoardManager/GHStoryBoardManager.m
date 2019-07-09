//
//  StoryBoardManager.m
//  HeMu
//
//  Created by sky on 2019/2/26.
//  Copyright © 2019年 sky. All rights reserved.
//

#import "GHStoryBoardManager.h"

@implementation GHStoryBoardManager

- (UIStoryboard *)homeStoryBoard{
    if (_homeStoryBoard == nil) {
        _homeStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    }
    return _homeStoryBoard;
}

- (UIStoryboard *)settingStoryBoard{
    if (_settingStoryBoard == nil) {
        _settingStoryBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    }
    return _settingStoryBoard;
}

- (UIStoryboard *)loginStoryBoard{
    if (_loginStoryBoard == nil) {
        _loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    }
    return _loginStoryBoard;
}

- (UIStoryboard *)messageStoryBoard{
    if (_messageStoryBoard == nil) {
        _messageStoryBoard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    }
    return _messageStoryBoard;
}

- (UIStoryboard *)mineStoryBoard{
    if (_mineStoryBoard == nil) {
        _mineStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    }
    return _mineStoryBoard;
}

@end
