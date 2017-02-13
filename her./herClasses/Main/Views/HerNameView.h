//
//  HerNameView.h
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//  名字view

#import "BaseView.h"

typedef void(^ClickSureBtnBlock)(NSString *name);
@interface HerNameView : BaseView

@property (nonatomic, strong) ClickSureBtnBlock sureBlock; /**< 确定回调 */

@end
