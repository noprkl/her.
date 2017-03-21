//
//  ChatPeopleView.h
//  her.
//
//  Created by 李祥起 on 2017/3/16.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseView.h"

typedef void(^ClickFirstBtnAction)();
typedef void(^ClickSecondBtnAction)();

@interface ChatPeopleView : BaseView

@property (nonatomic, strong) ClickFirstBtnAction firstBlock; /**< 第一个 */

@property (nonatomic, strong) ClickSecondBtnAction secondBlock; /**< 第二个 */

/**
 根据数据创建头像
 @param names 对方名字
 */
- (void)createChatPeopleWithArray:(NSArray *)names;

@end
