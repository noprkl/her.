//
//  DeleFocusCell.h
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDelBtnBlock)();
@interface DeleFocusCell : UITableViewCell

@property (nonatomic, strong) ClickDelBtnBlock delBlock; /**< 删除回调 */

@property (nonatomic, strong) NSString *str; /**< 标识 */

@end
