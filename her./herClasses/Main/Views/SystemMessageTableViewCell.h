//
//  SystemMessageTableViewCell.h
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDeleteButtonBlock)();
typedef void(^ClickAppointBtnBlock)();

@interface SystemMessageTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger state; /**< 消息类型 */


@property (nonatomic, strong) ClickDeleteButtonBlock deleteBlock; /**< 删除回调 */

@property (nonatomic, strong) ClickAppointBtnBlock appointBlock; /**< 赴约回调 */

@end
