//
//  LookHerAgainView.h
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//  继续匹配

#import <UIKit/UIKit.h>

typedef void(^ClickBeginButtonBlock)();
@interface LookHerAgainView : UIView

@property (nonatomic, strong) ClickBeginButtonBlock beginBlock; /**< 开始 */

@end
