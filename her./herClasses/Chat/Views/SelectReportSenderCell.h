//
//  SelectReportSenderCell.h
//  her.
//
//  Created by 李祥起 on 2017/3/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMessageModel.h"

typedef void(^SelectSenderDataBlock)(EaseMessageModel *senderModel);

@interface SelectReportSenderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) SelectSenderDataBlock senderBolck; /**< 发送回调 */

@property (nonatomic, strong) EaseMessageModel *senderModel; /**<  */

@property (nonatomic, assign) BOOL ishidSelectbtn; /**< 隐藏选中按钮 */

@property (nonatomic, assign) BOOL isSelected; /**< 是否选中状态 */

- (CGFloat)cellHeghit;
@end
