//
//  SelectReportAcceptCell.h
//  her.
//
//  Created by 李祥起 on 2017/3/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMessageModel.h"

typedef void(^SelectAcceptDataBlock)(EaseMessageModel *acceptModel);

@interface SelectReportAcceptCell : UITableViewCell

@property (nonatomic, strong) SelectAcceptDataBlock acceptBolck; /**< 接受回调 */

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) EaseMessageModel *acceptModel; /**<  */

@property (nonatomic, assign) BOOL isSelected; /**< 是否选中状态 */
- (CGFloat)cellHeghit;
@end
