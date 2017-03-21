//
//  DuelAlertView.h
//  her.
//
//  Created by 李祥起 on 2017/3/21.
//  Copyright © 2017年 LXq. All rights reserved.
//  决斗提示

#import "BaseView.h"

typedef void(^AccetpDuelBlock)();

@interface DuelAlertView : BaseView

@property (nonatomic, strong) AccetpDuelBlock duelBlock; /**< 应战回调 */

@property (nonatomic, strong) NSString *title; /**< 标题 */

- (instancetype)initWithFrame:(CGRect)frame isShowAccept:(BOOL)isShowAcceptBtn;
- (void)show;
- (void)dismiss;

@end
