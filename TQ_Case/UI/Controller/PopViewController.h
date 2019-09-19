//
//  PopViewController.h
//  TQ_Case
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 TQ. All rights reserved.
//

#import "BSViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PopViewControllerDelegate <NSObject>

@optional
-(void)delegateMethod:(EmployeeList *)coustomer;

@end
@interface PopViewController : BSViewController

@property (assign, nonatomic) id <PopViewControllerDelegate> delegate;

@property (strong , nonatomic) NSArray *list;

@end

NS_ASSUME_NONNULL_END
