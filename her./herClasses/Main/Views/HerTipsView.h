//
//  HerTipsView.h
//  her.
//
//  Created by ma c on 17/1/19.
//  Copyright © 2017年 LXq. All rights reserved.
//  Tips弹窗

#import "BaseView.h"

typedef void(^DismissBlock)();

@interface HerTipsView : BaseView

@property (nonatomic, strong) DismissBlock disBlock; /**< 消失回调 */

- (void)show;
- (void)dismiss;

@end
