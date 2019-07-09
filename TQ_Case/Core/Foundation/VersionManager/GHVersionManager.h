//
//  GHVersionManager.h
//  HaoChe-RentCar-iOS
//
//  Created by sky on 2017/8/25.
//  Copyright © 2017年 Chengdu MoonTeam Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHVersionManager : NSObject

@property (nonatomic, assign) BOOL versionNew; //是否有版本更新
@property (nonatomic, strong) NSString *appUpdateUrl; //app更新地址

@property(nonatomic, assign) BOOL forcedUpdate; //是否展示

@end
