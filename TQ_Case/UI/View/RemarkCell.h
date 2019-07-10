//
//  RemarkCell.h
//  TQ_Case
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 TQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextViewBlock)(NSString * remark);

@interface RemarkCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic) TextViewBlock textViewBlock;

+ (CGFloat)configCell0HeightWithInfo:(nullable id)info;
+ (RemarkCell *)configCell0:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
