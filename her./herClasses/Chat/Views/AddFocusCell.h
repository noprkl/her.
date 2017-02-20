//
//  AddFocusCell.h
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ClickAddBtnBlock)();
@interface AddFocusCell : UITableViewCell

//@property (nonatomic, strong) ClickAddBtnBlock addBlock; /**< 添加回调 */
@property (nonatomic, assign) BOOL isDel; /**< 是否已经删除 */

@property (nonatomic, strong) NSString *str; /**< 标识 */
@end
