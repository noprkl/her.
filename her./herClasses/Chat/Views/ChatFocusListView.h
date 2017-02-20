//
//  ChatFocusListView.h
//  her.
//
//  Created by 李祥起 on 2017/2/8.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteFocusBlock)(NSInteger index);
typedef void(^AddFocusBlock)();
@interface ChatFocusListView : UITableView

@property (nonatomic, strong) NSArray *focusArray; /**< 关注的人数据 */
@property (nonatomic, assign) BOOL isDel; /**< 决定了cell样式 */

@property (nonatomic, assign) NSInteger delIndex; /**< 决定了cell中心形图片 */
@property (nonatomic, assign) BOOL isShow; /**< 是否展示底部添加按钮 */

@property (nonatomic, strong) DeleteFocusBlock deleteBlock; /**< 删除 */

@property (nonatomic, strong) AddFocusBlock addBlock; /**< 添加关注 */

@end
